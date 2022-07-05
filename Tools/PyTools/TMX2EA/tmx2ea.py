
import six, tmx, sys, os, re, lzss, glob
import argparse

def showExceptionAndExit(exc_type, exc_value, tb):
    import traceback

    traceback.print_exception(exc_type, exc_value, tb)
    sys.exit(-1)

def tmxTileToGbafeTile(tileGid):
    return ((tileGid - 1) * 4) if tileGid != 0 else 0

def getIdentifierName(name):
    return re.sub(r"\W", '_', name)

class Tmx2EaError(Exception):

    def __init__(self, msg):
        self.message = msg

def getMapChangeGeometry(tmap, layer):
    """
    For given layer in given tiled map,
    returns a (x, y, width, height) tuple corresponding to
    the smallest rect containing all new tiles.
    """

    xMin = tmap.width
    yMin = tmap.height
    xMax = 0
    yMax = 0

    for iy in range(tmap.height):
        for ix in range(tmap.width):
            idx = iy * tmap.width + ix

            if layer.tiles[idx].gid != 0:
                xMin = xMin if xMin < ix else ix
                yMin = yMin if yMin < iy else iy
                xMax = xMax if xMax > ix else ix
                yMax = yMax if yMax > iy else iy

    return (xMin, yMin, xMax - xMin + 1, yMax - yMin + 1)

def getMapChangeData(tmap, layer, geometry):
    """
    For given layer in given tiled map, and geometry tuple,
    Returns the list of tile ids corresponding to the map change
    """

    tiles = []

    for iy in range(geometry[1], geometry[1] + geometry[3]):
        for ix in range(geometry[0], geometry[0] + geometry[2]):
            idx = iy * tmap.width + ix
            tiles.append(tmxTileToGbafeTile(layer.tiles[idx].gid))

    return tiles

class FeMapChange:

    def __init__(self):
        self.x      = 0
        self.y      = 0
        self.width  = 0
        self.height = 0

        self.tiles  = []
        self.name   = ""
        self.number = -1

    @staticmethod
    def makeFromLayer(tmap, layer):
        geo = getMapChangeGeometry(tmap, layer)
        tiles = getMapChangeData(tmap, layer, geo)

        result = FeMapChange()

        result.x      = geo[0]
        result.y      = geo[1]
        result.width  = geo[2]
        result.height = geo[3]

        result.tiles  = tiles

        result.name   = getIdentifierName(layer.name)

        for p in layer.properties:
            if p.name.upper() == 'ID':
                try:
                    result.number = int(p.value, base = 0)

                except ValueError:
                    result.number = int(p.value)

        return result

class MapPropertyInfo:

    def __init__(self, default, aliases):
        self.default = default # str
        self.aliases = aliases # str[]

class FeMap:

    def __init__(self, size, mainLayer, mapChanges, properties):
        self.size       = size       # (int, int)
        self.mapChanges = mapChanges # FeMapChange[]
        self.mainLayer  = mainLayer  # int[]
        self.properties = properties # { str: str }

    def genMissingMapChangeIds(self):
        """
        Fill out unset tile ids with unused ids
        """

        # building set of used map change ids
        ids = { mapChange.number for mapChange in self.mapChanges if mapChange.number >= 0 }

        # i is counter for map change id (start at -1 as we add 1 before checking each time)
        i = -1

        for mapChange in self.mapChanges:
            if mapChange.number >= 0:
                continue

            i = i + 1 # ensure we are not re-using any ids

            # find next unused id
            while i in ids:
                i = i + 1

            mapChange.number = i

    def normalizeProperties(self, infoDict):
        """
        resolves missing properties by setting defaults and checking for aliases
        according to the rules provided by the infoDict arg (dict of str to MapPropertyInfo)
        """

        for name, info in infoDict.items():
            hasProp = name in self.properties

            for alias in info.aliases:
                if alias in self.properties:
                    if not hasProp:
                        self.properties[name] = self.properties[alias]
                        hasProp = True

                    else:
                        # alias present while property is already defined!
                        raise Tmx2EaError("property '{}' is defined more than once via alias '{}'!".format(
                            name, alias))

                    del self.properties[alias]

            if not hasProp:
                # setting default value
                self.properties[name] = info.default

    @staticmethod
    def makeFromTiledMap(tmap):
        if (tmap.tilewidth != 16) or (tmap.tileheight != 16):
            raise Tmx2EaError("bad tile size! tile size should be 16x16 pixels")

        size = (tmap.width, tmap.height)

        mapChanges = []
        mainLayer  = None
        properties = None

        for layer in tmap.layers:
            isMain = False

            if layer.name.lower() == "main":
                isMain = True

            elif len(tmap.layers) == 1:
                isMain = True

            else:
                for p in layer.properties:
                    if (p.name.lower() == "main"):
                        isMain = True

            if isMain:
                # If is main layer, take tiles and properties from it
                if mainLayer:
                    raise Tmx2EaError("this map has multiple main layers!")

                properties = { p.name.lower(): p.value for p in layer.properties if (p.name.lower() != 'main' and p.value and p.value != '') }
                mainLayer = [tmxTileToGbafeTile(tile.gid) for tile in layer.tiles]

            else:
                # Otherwise, it is a map change layer and we will generate a map change from it
                mapChanges.append(FeMapChange.makeFromLayer(tmap, layer))

        if not mainLayer:
            raise Tmx2EaError("this map has no main layer!")

        return FeMap(size, mainLayer, mapChanges, properties)

    def getMapDataBytes(self):
        """
        Generates main layer data that is to be compressed.
        """

        u16Array = [self.size[0] + (self.size[1] << 8)] + self.mainLayer
        return b''.join([x.to_bytes(2, 'little') for x in u16Array])

def genHeaderLines():
    yield '#include "EAstdlib.event"\n\n'

    yield "#ifndef TMX2EA\n"
    yield "#define TMX2EA\n\n"

    yield "#ifndef ChapterDataTable\n"
    yield "    #ifdef _FE7_\n"
    yield "        #define ChapterDataTable 0xC9A200\n"
    yield "        #define ChapterDataTableEntSize 152\n"
    yield "    #endif\n"
    yield "    #ifdef _FE8_\n"
    yield "        #define ChapterDataTable 0x8B0890\n"
    yield "        #define ChapterDataTableEntSize 148\n"
    yield "    #endif\n"
    yield "#endif\n\n"

    yield '#define SetChapterData(ChapterID,ObjectType1,ObjectType2,PaletteID,TileConfig,MapID,MapPointer,Anims1,Anims2,MapChanges) "PUSH; ORG ChapterDataTable+(ChapterID*ChapterDataTableEntSize)+4; BYTE ObjectType1 ObjectType2 PaletteID TileConfig MapID Anims1 Anims2 MapChanges; EventPointerTable(MapID,MapPointer); POP"\n\n'

    yield "#endif // TMX2EA\n\n"

KEY_PROPERTY_IMAGE1  = "objecttype1"
KEY_PROPERTY_IMAGE2  = "objecttype2"
KEY_PROPERTY_PALETTE = "paletteid"
KEY_PROPERTY_CONFIG  = "tileconfig"
KEY_PROPERTY_ANIMS1  = "anims1"
KEY_PROPERTY_ANIMS2  = "anims2"

KEY_PROPERTY_CHAPTER = "chapterid"
KEY_PROPERTY_MAPID   = "mapid"
KEY_PROPERTY_MAPCID  = "mapchangesid"

TMX2EA_PROPERTY_DICT = {
    KEY_PROPERTY_IMAGE1:  MapPropertyInfo("ObjectType",  ["objecttype"]),
    KEY_PROPERTY_IMAGE2:  MapPropertyInfo("0",           []),
    KEY_PROPERTY_PALETTE: MapPropertyInfo("PaletteID",   []),
    KEY_PROPERTY_CONFIG:  MapPropertyInfo("TileConfig",  []),
    KEY_PROPERTY_ANIMS1:  MapPropertyInfo("0",           ["anims"]),
    KEY_PROPERTY_ANIMS2:  MapPropertyInfo("0",           []),

    KEY_PROPERTY_CHAPTER: MapPropertyInfo("ChapterID",   []),
    KEY_PROPERTY_MAPID:   MapPropertyInfo("map_id",      []),
    KEY_PROPERTY_MAPCID:  MapPropertyInfo("map_changes", []),
}

def process(tmxFilename, eventFilename, dmpFilename, boolAddHeader):
    """
    Generates eventFilename and dmpFilename from tmxFilename
    """

    feMap = FeMap.makeFromTiledMap(tmx.TileMap.load(tmxFilename))

    feMap.genMissingMapChangeIds()
    feMap.normalizeProperties(TMX2EA_PROPERTY_DICT)

    if len(feMap.mapChanges) == 0:
        feMap.properties[KEY_PROPERTY_MAPCID] = "0"

    # WRITE DMP FILE

    with open(dmpFilename, 'wb') as f:
        lzss.compress(feMap.getMapDataBytes(), f)

    # WRITE EVENT FILE

    with open(eventFilename, 'w') as f:
        if boolAddHeader:
            f.writelines(genHeaderLines())

        f.write("// Map Data Installer Generated by tmx2ea\n")
        f.write('\n{\n')

        f.write("\nALIGN 4\nMapData:\n  #incbin \"{}\"\n".format(os.path.relpath(dmpFilename, os.path.dirname(eventFilename))))

        f.write("\nSetChapterData({}, {}, {}, {}, {}, {}, MapData, {}, {}, {})\n".format(
            feMap.properties[KEY_PROPERTY_CHAPTER],
            feMap.properties[KEY_PROPERTY_IMAGE1],
            feMap.properties[KEY_PROPERTY_IMAGE2],
            feMap.properties[KEY_PROPERTY_PALETTE],
            feMap.properties[KEY_PROPERTY_CONFIG],
            feMap.properties[KEY_PROPERTY_MAPID],
            feMap.properties[KEY_PROPERTY_ANIMS1],
            feMap.properties[KEY_PROPERTY_ANIMS2],
            feMap.properties[KEY_PROPERTY_MAPCID]))

        if len(feMap.mapChanges) != 0:
            for mapChange in feMap.mapChanges:
                f.write("\nALIGN 4\n")
                f.write("{}:\n".format(mapChange.name))
                f.write("  SHORT {}\n".format(' '.join('${:X}'.format(tile) for tile in mapChange.tiles)))

            f.write("\nALIGN 4\nMapChangesData:\n")

            for mapChange in feMap.mapChanges:
                f.write('  TileMap({}, {}, {}, {}, {}, {})\n'.format(
                    mapChange.number,
                    mapChange.x,
                    mapChange.y,
                    mapChange.width,
                    mapChange.height,
                    mapChange.name))

            f.write('  TileMapEnd\n')

            f.write("\nEventPointerTable({}, MapChangesData)\n".format(
                feMap.properties[KEY_PROPERTY_MAPCID]))

        f.write('\n}\n')

def main():
    sys.excepthook = showExceptionAndExit
    createInstaller = False

    parser = argparse.ArgumentParser(description = 'Convert TMX file(s) to EA events. When no arguments are given, will ask what to do. If given a list of tmx files, will process them all. If given the `-s` option, will scan current directory for tmx files, process them all, and generate a master installer.')

    # input
    parser.add_argument("tmxFiles", nargs='*', help="path to tmx file(s) to process") #all arguments are tmx files
    parser.add_argument("-s", "--scanfolders", action="store_true", help="scan all subfolders and generate master installer") #optional scan

    # output
    parser.add_argument("-O", '--installer', help = 'output installer event (default: [Folder]/Master Map Installer.event)')
    
    # options
    parser.add_argument("-H", "--noheader", action="store_true", help="do not add in the tmx2ea header in generated file(s)")

    args = parser.parse_args()

    if (not args.tmxFiles) and (not args.scanfolders): #no arguments given and scanfolders is not true
        import tkinter as tk
        from tkinter import filedialog, messagebox

        root = tk.Tk()
        root.withdraw()

        if messagebox.askyesno("Folder Scan", "Scan all subfolders for .tmx files?"):
            args.scanfolders = True

        else:
            tmxFile = filedialog.askopenfilename(
                title = "Select TMX file to process",
                initialdir = os.getcwd(),
                filetypes = [
                    ("TMX files", ".tmx"),
                    ("All files", ".*")
                ]
            )
            
            if tmxFile == "":
                input("No file given.\nPress Enter key to exit.")
                sys.exit(-1)
            
            else:
                args.tmxFiles = [ tmxFile ]
    
    if args.scanfolders:
        args.tmxFiles = glob.glob('**/*.tmx',recursive=True)
        createInstaller = True

    processedFiles = []

    for tmxFilename in args.tmxFiles:
        eventFilename = os.path.splitext(tmxFilename)[0]+".event"
        dmpFilename   = os.path.splitext(tmxFilename)[0]+"_data.dmp"

        try:
            process(tmxFilename, eventFilename, dmpFilename, not args.noheader)
            processedFiles.append(eventFilename)

        except Tmx2EaError as e:
            sys.exit("ERROR: {}: {}".format(tmxFilename, e.message))

    if createInstaller:
        installerFile = args.installer if args.installer else "Master Map Installer.event"

        with open(installerFile, 'w') as f:
            f.writelines(map(lambda file: '#include "{}"\n'.format(os.path.relpath(file, os.path.dirname(installerFile))), processedFiles))

if __name__ == '__main__':
    main()
