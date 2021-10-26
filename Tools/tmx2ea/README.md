# TMX2EA

TMX2EA converts Tiled format maps to EA installer format.

## How to use

Simply double click TMX2EA.exe and choose "Yes" to scan subfolders, and it will generate individual installers for each map as well as a master installer for all maps found.

If you only wish to update a single map you can either drag the .tmx directly onto TMX2EA or choose "No" when prompted and use the file selection dialog.

To use the installer, put

    ORG (some free space)
    #include "Path/To/Master Map Installer.event"

in your rom buildfile.

---

The Map Installer define the `SetChapterData()` macro, which is used to update the Chapter Data Editor with the appropriate properties. You can override the behavior of that macro by defining `TMX2EA` as well as that macro before including any map installer.

These properties can be manually set in the generated event files, or defined as custom layer properties.

Supported 'Main' layer Properties:

| Name         | Default Value  | Notes                                                    |
| ------------ | -------------- | -------------------------------------------------------- |
| Main         |                | Has the same effect as naming the layer 'Main'.          |
| ChapterID    | ChapterID      | The chapter number/row in the chapter data editor.       |
| ObjectType1  | ObjectType     | The object set to use. Alias: ObjectType.                |
| ObjectType2  | 0              |                                                          |
| PaletteID    | PaletteID      | The palette to use.                                      |
| TileConfig   | TileConfig     | The tile configuration to use.                           |
| MapID        | map_id         | The index of the map in the Event Pointer Table.         |
| MapChangesID | map_changes    | The index of the map changes in the Event Pointer Table. |
| Anims1       | 0              | Tile Animation to use. Alias: Anims.                     |
| Anims2       | 0              |                                                          |

Supported map change properties:

| Name         | Notes                                                                             |
| ------------ | --------------------------------------------------------------------------------- |
| ID           | Map Change numerical identifier. By default, picks an unused one starting from 1. |

Note that the `X`, `Y`, `Width` and `Height` properties don't do anything anymore: map change dimentions are now computed automatically from the tile layout. You may however still want to add them for compatibility with older versions that required them.

Command line arguments:

    usage: tmx2ea.py [-h] [-s] [-O INSTALLER] [-H] [tmxFiles [tmxFiles ...]]

    Convert TMX file(s) to EA events. When no arguments are given, will ask what
    to do. If given a list of tmx files, will process them all. If given the `-s`
    option, will scan current directory for tmx files, process them all, and
    generate a master installer.

    positional arguments:
      tmxFiles              path to tmx file(s) to process

    optional arguments:
      -h, --help            show this help message and exit
      -s, --scanfolders     scan all subfolders and generate master installer
      -O INSTALLER, --installer INSTALLER
                            output installer event (default: [Folder]/Master Map
                            Installer.event)
      -H, --noheader        do not add in the tmx2ea header in generated file(s)
