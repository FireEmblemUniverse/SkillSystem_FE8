from PIL import Image
import numpy
import os
import struct

READ_AHEAD_BUFFER_SIZE = 0x00000012
SLIDING_WINDOW_SIZE = 0x00001000


def b(v: int):
    return v.to_bytes(1, "little")


def length_of_match(data, x, y):
    """Calculates the number of consecutive characters that are the same starting at x and y in data."""
    for c in range(READ_AHEAD_BUFFER_SIZE):
        if (y + c) >= len(data):
            return c
        if data[x + c] != data[y + c]:
            return c
    return READ_AHEAD_BUFFER_SIZE


def search(data, position):
    length = len(data)
    if (position < 3) or ((length - position) < 3):
        return 0, 0
    result = 0, 0
    for i in range(max(0, position - SLIDING_WINDOW_SIZE), position - 1):
        current = length_of_match(data, i, position)
        if current >= result[0]:
            result = (current, position - i)
    return result


def blocks(data):
    position = 0
    while position < len(data):
        compression_flags = 0
        temp = b''
        for bit in (128, 64, 32, 16, 8, 4, 2, 1):
            if position >= len(data):
                break

            size, where = search(data, position)

            if size > 2:
                temp += b((((size - 3) & 0xF) << 4) + (((where - 1) >> 8) & 0xF))
                temp += b((where - 1) & 0xFF)
                position += size
                compression_flags |= bit
            else:
                temp += b(data[position])
                position += 1

        yield b(compression_flags) + temp


def compress(data):
    l = len(data)

    result = b''.join(
        (b'\x10', b(l & 0xff), b((l >> 8) & 0xff), b((l >> 16) & 0xff)) +
        tuple(blocks(data))
    )

    return result + b'\x00' * (-len(result) % 4)


try:
    import pyfastgbalz77
    compress = lambda x: pyfastgbalz77.compress(x, False)
except ImportError:
    pass


def to_gba(arr):
    arr = arr.astype('<u1')
    buffer = split8x8(arr).flatten()
    buffer = (buffer[1::2] << 4) + buffer[::2]
    return buffer


def split8x8(arr):
    h, w = arr.shape
    return arr.reshape(h // 8, 8, -1, 8).swapaxes(1, 2).reshape(-1, 8, 8)


def palette_to_bytes(palette):
    buffer = b""
    f = lambda x: (x >> 3) & 0x1f
    if len(palette) < 16:
        palette += [(0, 0, 0)] * (16 - len(palette))
    for r, g, b in palette:
        dr, dg, db = f(r), f(g), f(b)
        v = dr + (dg << 5) + (db << 10)
        buffer += struct.pack("<H", v)
    return buffer

header ="""{
#ifndef __mx_mug
#define __mx_mug(mugEntry, mugLocation)"PUSH; ORG PortraitTable+mugEntry*0x1C; POIN mugLocation; POIN mugLocation+0x1624; POIN mugLocation+0x1604; POIN mugLocation+0x1004; WORD 0; "
#endif

"""

HEADER = bytes([0x00, 0x04, 0x10, 0x00])


def cut_image(arr):
    portrait = numpy.zeros((32, 256))
    frames = numpy.zeros((8, 384))

    minimug = arr[16: 48, 96: 128]

    portrait[0: 32, 160: 176] = arr[48: 80, 0: 16]
    portrait[0: 32, 176: 192] = arr[48: 80, 80: 96]
    portrait[0: 32, 0: 64] = arr[0: 32, 16: 80]
    portrait[0: 32, 64: 128] = arr[32: 64, 16: 80]
    portrait[0: 16, 128: 160] = arr[64: 80, 16: 48]
    portrait[16: 32, 128: 160] = arr[64: 80, 48: 80]

    portrait[0: 16, 192: 224] = arr[48: 64, 96: 128]
    portrait[16: 32, 192: 224] = arr[64: 80, 96: 128]
    portrait[0: 16, 224: 256] = arr[80: 96, 96: 128]
    portrait[16: 32, 224: 256] = arr[96: 112, 96: 128]

    frames[:, 0: 32] = arr[80: 88, 0: 32]
    frames[:, 32: 64] = arr[88: 96, 0: 32]
    frames[:, 64: 96] = arr[80: 88, 32: 64]
    frames[:, 96: 128] = arr[88: 96, 32: 64]
    frames[:, 128: 160] = arr[80: 88, 64: 96]
    frames[:, 160: 192] = arr[88: 96, 64: 96]

    frames[:, 192: 224] = arr[96: 104, 0: 32]
    frames[:, 224: 256] = arr[104: 112, 0: 32]
    frames[:, 256: 288] = arr[96: 104, 32: 64]
    frames[:, 288: 320] = arr[104: 112, 32: 64]
    frames[:, 320: 352] = arr[96: 104, 64: 96]
    frames[:, 352: 384] = arr[104: 112, 64: 96]
    
    return portrait, frames, minimug


SEARCH_RANGE = 1, 7


def cv_locate_eye_mouse_pos(arr):
    eye = arr[48: 64, 96: 128]
    mouth = arr[80: 96, 96: 128]
    face = arr[:80, :96]
    min_eye = 0, 0
    min_mouth = 0, 0
    min_eye_diff = 512
    min_mouth_diff = 512
    for i in range(SEARCH_RANGE[0], SEARCH_RANGE[1] + 1):
        for j in range(SEARCH_RANGE[0], SEARCH_RANGE[1] + 1):
            slice = face[8 * i: 8 * i + 16, 8 * j: 8 * j + 32]
            eye_diff = numpy.sum(numpy.sign(numpy.abs(slice - eye)))
            mouth_diff = numpy.sum(numpy.sign(numpy.abs(slice - mouth)))
            if eye_diff < min_eye_diff:
                min_eye = j, i
                min_eye_diff = eye_diff
            if mouth_diff < min_mouth_diff:
                min_mouth = j, i
                min_mouth_diff = mouth_diff
    return min_mouth[0], min_mouth[1], min_eye[0], min_eye[1]


def portrait_to_dmp(image_file):
    dump_file = f"{image_file[:-4]}.dmp"
    pos_file = f"{image_file[:-4]}.pos.dmp"
    image: Image.Image = Image.open(image_file)
    try:
        palette = image.palette.colors
        if len(palette) > 17:
            image = image.quantize(16)
    except AttributeError:
        image = image.quantize(16)
    palette = [i for i in image.palette.colors][:16]
    arr = numpy.array(image.getdata(), dtype='<u1').reshape((112, 128))
    transparent = arr[0][0]
    if transparent != 0:
        palette[0], palette[transparent] = palette[transparent], palette[0]
        arr = arr + (arr == 0) * 20
        arr = arr - (arr == transparent) * transparent
        arr = arr - (arr == 20) * (20 - transparent)
    portrait, frames, minimug = cut_image(arr)

    portrait = HEADER + to_gba(portrait).tobytes()
    frames = to_gba(frames).tobytes()
    minimug = compress(to_gba(minimug).tobytes())
    palette = palette_to_bytes(palette)
    buffer = portrait + frames + palette + minimug
    x1, y1, x2, y2 = cv_locate_eye_mouse_pos(arr)
    mouse_eye_pos = x1.to_bytes(1, "little") + y1.to_bytes(1, "little") + x2.to_bytes(1, "little") + y2.to_bytes(1, "little")
    with open(dump_file, "wb") as file:
        file.write(buffer)
    with open(pos_file, "wb") as file:
        file.write(mouse_eye_pos)

installer = header
for file in os.listdir("."):
    if not file.endswith(".png"):
        continue
    portrait_to_dmp(file)
    installer += f"""    {{
        __mx_mug({file[:-4]}Mug, __mug_dmp)
        #incbin "{file[:-4]}.pos.dmp"
        BYTE 1 0 0 0; POP;
        align 4
        __mug_dmp:
            #incbin "{file[:-4]}.dmp"
    }}\n
"""

installer += "}\n"
with open("Installer.event", "w") as file:
    file.write(installer)
