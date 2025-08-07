# -*- coding: utf-8 -*-
# used http://code.google.com/p/u-lzss/source/browse/trunk/js/lib/ulzss.js as
# a guide
from sys import stderr

from collections import defaultdict
from operator import itemgetter
from struct import pack, unpack

class SlidingWindow:
    # The size of the sliding window
    size = 4096

    # The minimum displacement.
    disp_min = 2

    # The hard minimum — a disp less than this can't be represented in the
    # compressed stream.
    disp_start = 1

    # The minimum length for a successful match in the window
    match_min = 1

    # The maximum length of a successful match, inclusive.
    match_max = None

    def __init__(self, buf):
        self.data = buf
        self.hash = defaultdict(list)
        self.full = False

        self.start = 0
        self.stop = 0
        #self.index = self.disp_min - 1
        self.index = 0

        assert self.match_max is not None

    def next(self):
        if self.index < self.disp_start - 1:
            self.index += 1
            return

        if self.full:
            olditem = self.data[self.start]
            assert self.hash[olditem][0] == self.start
            self.hash[olditem].pop(0)

        item = self.data[self.stop]
        self.hash[item].append(self.stop)
        self.stop += 1
        self.index += 1

        if self.full:
            self.start += 1
        else:
            if self.size <= self.stop:
                self.full = True

    def advance(self, n=1):
        """Advance the window by n bytes"""
        for _ in range(n):
            self.next()

    def search(self):
        match_max = self.match_max
        match_min = self.match_min

        counts = []
        indices = self.hash[self.data[self.index]]
        for i in indices:
            matchlen = self.match(i, self.index)
            if matchlen >= match_min:
                disp = self.index - i
                #assert self.index - disp >= 0
                #assert self.disp_min <= disp < self.size + self.disp_min
                if self.disp_min <= disp:
                    counts.append((matchlen, -disp))
                    if matchlen >= match_max:
                        #assert matchlen == match_max
                        return counts[-1]

        if counts:
            match = max(counts, key=itemgetter(0))
            return match

        return None

    def match(self, start, bufstart):
        size = self.index - start

        if size == 0:
            return 0

        matchlen = 0
        it = range(min(len(self.data) - bufstart, self.match_max))
        for i in it:
            if self.data[start + (i % size)] == self.data[bufstart + i]:
                matchlen += 1
            else:
                break
        return matchlen

class NLZ10Window(SlidingWindow):
    size = 4096

    match_min = 3
    match_max = 3 + 0xf

class NLZ11Window(SlidingWindow):
    size = 4096

    match_min = 3
    match_max = 0x111 + 0xFFFF

class NOverlayWindow(NLZ10Window):
    disp_min = 3

def _compress(input, windowclass=NLZ10Window):
    """Generates a stream of tokens. Either a byte (int) or a tuple of (count,
    displacement)."""

    window = windowclass(input)

    i = 0
    while True:
        if len(input) <= i:
            break
        match = window.search()
        if match:
            yield match
            #if match[1] == -283:
            #    raise Exception(match, i)
            window.advance(match[0])
            i += match[0]
        else:
            yield input[i]
            window.next()
            i += 1

def packflags(flags):
    n = 0
    for i in range(8):
        n <<= 1
        try:
            if flags[i]:
                n |= 1
        except IndexError:
            pass
    return n

def chunkit(it, n):
    buf = []
    for x in it:
        buf.append(x)
        if n <= len(buf):
            yield buf
            buf = []
    if buf:
        yield buf


def compress(input):
    # header
    out = b''
    out += (pack("<L", (len(input) << 8) + 0x10))

    # body
    length = 0
    for tokens in chunkit(_compress(input), 8):
        flags = [type(t) == tuple for t in tokens]
        out += (pack(">B", packflags(flags)))

        for t in tokens:
            if type(t) == tuple:
                count, disp = t
                count -= 3
                disp = (-disp) - 1
                assert 0 <= disp < 4096
                sh = (count << 12) | disp
                out += (pack(">H", sh))
            else:
                out += (pack(">B", t))

        length += 1
        length += sum(2 if f else 1 for f in flags)

    # padding
    padding = 4 - (length % 4 or 4)
    if padding:
        out += (b'\x00' * padding)
    return out

def compress_to_file(input, out):
    # header
    out.write(pack("<L", (len(input) << 8) + 0x10))

    # body
    length = 0
    for tokens in chunkit(_compress(input), 8):
        flags = [type(t) == tuple for t in tokens]
        out.write(pack(">B", packflags(flags)))

        for t in tokens:
            if type(t) == tuple:
                count, disp = t
                count -= 3
                disp = (-disp) - 1
                assert 0 <= disp < 4096
                sh = (count << 12) | disp
                out.write(pack(">H", sh))
            else:
                out.write(pack(">B", t))

        length += 1
        length += sum(2 if f else 1 for f in flags)

    # padding
    padding = 4 - (length % 4 or 4)
    if padding:
        out.write(b'\xff' * padding)

def compress_nlz11(input, out):
    # header
    out.write(pack("<L", (len(input) << 8) + 0x11))

    # body
    length = 0
    for tokens in chunkit(_compress(input, windowclass=NLZ11Window), 8):
        flags = [type(t) == tuple for t in tokens]
        out.write(pack(">B", packflags(flags)))
        length += 1

        for t in tokens:
            if type(t) == tuple:
                count, disp = t
                disp = (-disp) - 1
                #if disp == 282:
                #    raise Exception
                assert 0 <= disp <= 0xFFF
                if count <= 1 + 0xF:
                    count -= 1
                    assert 2 <= count <= 0xF
                    sh = (count << 12) | disp
                    out.write(pack(">H", sh))
                    length += 2
                elif count <= 0x11 + 0xFF:
                    count -= 0x11
                    assert 0 <= count <= 0xFF
                    b = count >> 4
                    sh = ((count & 0xF) << 12) | disp
                    out.write(pack(">BH", b, sh))
                    length += 3
                elif count <= 0x111 + 0xFFFF:
                    count -= 0x111
                    assert 0 <= count <= 0xFFFF
                    l = (1 << 28) | (count << 12) | disp
                    out.write(pack(">L", l))
                    length += 4
                else:
                    raise ValueError(count)
            else:
                out.write(pack(">B", t))
                length += 1

    # padding
    padding = 4 - (length % 4 or 4)
    if padding:
        out.write(b'\xff' * padding)

def dump_compress_nlz11(input, out):
    # body
    length = 0
    def dump():
        for t in _compress(input, windowclass=NLZ11Window):
            if type(t) == tuple:
                yield t
    from pprint import pprint
    pprint(list(dump()))

if __name__ == '__main__':
    from sys import stdout, argv
    data = open(argv[1], "rb").read()
    stdout = stdout.detach()
    #compress(data, stdout)
    compress_nlz11(data, stdout)

    #dump_compress_nlz11(data, stdout)