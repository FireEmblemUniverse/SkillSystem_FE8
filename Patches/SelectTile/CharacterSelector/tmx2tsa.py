
import argparse
import tmx
import struct

parser = argparse.ArgumentParser()
parser.add_argument('file',help='TMX file to parse.')
parser.add_argument('output',help='Output dump file.')
parser.add_argument('-p','--paletteID',default=1,type=int,help='Palette ID for TSA. Default is 1.')
parser.add_argument('-c','--compress',help='Filepath to compress.exe for lz77 compression.')
args = parser.parse_args()

tsa = [] # List of shorts to write.
class TSA:
    def __init__(self,width,height,tiles,paletteID): # List of bytes.
        self.width = width # Width is the length per list.
        self.height = height
        #print([e.gid for e in tiles])
        self.tiles = [ tiles[i:i+self.width] for i in range(0,self.width*self.height,self.width) ] # This sorts the rows in reverse order.
        self.tiles.reverse()
        for row in self.tiles:
            print([e.gid for e in row])
        self.paletteID = paletteID
    def write(self,file): # Output width-1, height-1, and then the list of struct unsigned halfwords.
        with open(file,'wb') as out:
            out.write(bytes([self.width-1,self.height-1]))
            for row in self.tiles:
                for tile in row:
                    out.write(struct.pack('<H',(tile.gid-1)|(tile.hflip<<10)|(tile.vflip<<11)|(self.paletteID<<12)))
    def __str__(self):
        return f'Width: {self.width}\nHeight: {self.height}\nTiles:\nself.tiles'

if __name__ == '__main__':
    if args.paletteID > 8 or args.paletteID < 0:
        exit(f'Error in parsing {args.file}: Palette ID must be between 0 and 7 inclusive.')
    map = tmx.TileMap.load(args.file)
    if map.tilewidth != 8 or map.tileheight != 8:
        exit(f'Error in parsing {args.file}: Tile width and height both must be 8.')
    
    tsa = TSA(map.width,map.height,map.layers[0].tiles,args.paletteID)   
    tsa.write(args.output)
    
    if args.compress:
        compressed = subprocess.run([args.compress,args.output],capture_output=True).stdout
        with open(output,'wb') as out:
            out.write(compressed)
