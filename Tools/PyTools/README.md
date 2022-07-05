Collection of python (3) tools for make/EA. Most tools output EA events.

# Usage

## `c2ea`

```
usage: c2ea.py [-h] [-csv CSV] [-nmm NMM] [-out OUT] [-folder FOLDER]
               [-installer INSTALLER]
               [rom]

Convert CSV file(s) to EA events using NMM file(s) as reference. Defaults to
looking for CSVs in the current directory. You can specify a directory to look
in using -folder, or you can switch to processing singles CSVs using -csv.

positional arguments:
  rom                   reference ROM (for pointer searching)

optional arguments:
  -h, --help            show this help message and exit
  -csv CSV              CSV for single csv processing
  -nmm NMM              (use with -csv) reference NMM (default:
                        [CSVFile]:.csv=.nmm)
  -out OUT              (use with -csv) output event (default:
                        [CSVFile]:.csv=.event)
  -folder FOLDER        folder to look for csvs in
  -installer INSTALLER  output installer event (default: [Folder]/Table
                        Installer.event)
```

*See `NMM2CSV/README.md` for details.*

## `tmx2ea`

```
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
```

*See `TMX2EA/README.md` for details.*

## `text-process`

***Note***: This is deprecated. Consider using `text-process-classic` instead.

```sh
(python3) "text-process.py" <input text> <output installer> <output definitions>
```

Note that, unlike for the original textprocess which generates `#incext`s, the output installer will `#incbin` a series of `xyz.fetxt.dmp` files, but the program only generates `xyz.fetxt` files. It is your responsibility to ensure the `fetxt.dmp` file is made from the `fetxt` file; such as by using a make rule involving a `ParseFile` invocation, perhaps. Ex:

```make
%.fetxt.dmp: %.fetxt
	ParseFile $< -o $@
```

The idea is that you get the "list" of `fetxt.dmp` files to generate through dependency analysis with Event Assembler. (I may add support for listing dependencies in text-process itself in the future).

## `text-process-classic`

```sh
(python3) "text-process-classic.py" <input text> [--installer <output installer>] [--definitions <output definitions>] [--parser-exe <path/to/ParseFile>] [--force-refresh]
```

Version of `text-process` that is more Classic!MakeHack-friendly.

TODO: help

## `portrait-process`

```
usage: portrait-process.py [-h] [--list-files | -o OUTPUT] input

positional arguments:
  input                 input list file

optional arguments:
  -h, --help            show this help message and exit
  --list-files          print installer dependencies
  -o OUTPUT             output installer filename
```

The input list file follows this format:

    <path to portrait png> <mug index> <mouth x> <mouth y> <eyes x> <eyes y> [mug index definition]
    ...

Empty lines and lines where the first character is `#` (comments) are ignored. You can therefore use a comment to remind you of the line format. Here's an example list file:

    #                       Index MouthX MouthY EyesX EyesY IndexDefinition
    "Portraits/Florina.png" 0x02  2      7      3     5     MUG_FLORINA

You can use quotes around parameters (as demonstrated above). This can be used to allow spaces in parameters (although I'd strongly recommend against that) or just to make the file nicer to read (this is very opinions).

[See here for a larger example](https://github.com/StanHash/VBA-MAKE/blob/master/Spritans/PortraitList.txt) (Lists all VBA portraits).

As for text-process, portrait-process doesn't generate any actual portrait data. It is your responsibility to make sure the files `<Portrait>_mug.dmp`, `<Portrait>_palette.dmp`, `<Portrait>_frames.dmp` and `<Portrait>_minimug.dmp` are generated from `<Portrait>.png`. Again, this is best done through a make rule involving a `PortraitFormatter` invocation:

```make
%_mug.dmp %_palette.dmp %_frames.dmp %_minimug.dmp: %.png
	PortraitFormatter $<
```

The "list" of portrait data files to generate can be get through usage of the `--list-files` option (note that it will not both list files and generate an installer at the same time).

# Credits

Most tools were based off circleseverywhere's work.

| name               | original authors           | further additions  | notes |
| ------------------ | -------------------------- | ------------------ | ----- |
| `c2ea` & `n2c`     | circleseverywhere, zahlman | Crazycolorz5, Stan | - |
| `tmx2ea`           | circleseverywhere          | Stan               | - |
| `text-process`     | circleseverywhere          | Stan               | relies on `ParseFile` by CrazyColorz5 |
| `portrait-process` | Stan                       | -                  | relies on `PortraitFormatter` by CrazyColorz5 |
