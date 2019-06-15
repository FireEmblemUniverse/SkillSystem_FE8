import re, os, sys

def show_exception_and_exit(exc_type, exc_value, tb):
  import traceback
  traceback.print_exception(exc_type, exc_value, tb)
  input("Press Enter key to exit.")
  sys.exit(-1)

def process_script(path):
  """Script format is:
  #frames image.png
  e.g.
  5 frame1.png
  5 frame2.png
  """
  scriptdata = []
  with open(path,'r') as script:
    lines = script.readlines()
    pattern = re.compile(r"""(\d+)                  # duration
                                \s+                 # space
                                ([\w-]+\.[Pp][Nn][Gg]| # filename
                                ".+\.[Pp][Nn][Gg]") # filename with spaces
                          """, re.X)
    for line in lines:
      lin = line.strip()
      match = pattern.match(lin)
      if match:
        scriptdata.append(match.group(1,2))
  return scriptdata

def gritify(path):
  os.system(os.path.join("grit", 'grit {} -gB 4 -gzl -m -mLf -mR4 -mzl -pn 16 -ftb -fh!'.format(path)))

def main():
  sys.excepthook = show_exception_and_exit
  assert len(sys.argv) == 2, "No script given. Drag and drop a script onto the program to run."
  frames = "Frames:    //SHORT image duration\n"
  frame_end = "SHORT 0xFFFF\nALIGN 4\n"
  tsalist = "TSAList:\n"
  graphicslist = "GraphicsList:\n"
  paletteslist = "PalettesList:\n"
  tsa = ""
  graphics = ""
  palettes = ""

  scriptpath = sys.argv[1]

  outputpath = os.path.splitext(scriptpath)[0]+".event"

  data = process_script(scriptpath) #path to script given
  framesref = {} # dictionary of image path=>number pairs.
  for dat in data:
    duration = dat[0]
    path = dat[1]
    basepath = os.path.splitext(path)[0].replace('"','')
    label = basepath.replace(' ','_').replace('-','_')
    try:
      num = framesref[path]
    except KeyError:
      framesref[path] = len(framesref)
      gritify(path)
      num = framesref[path]
      tsa += 'TSA_{}:\n#incbin "{}.map.bin"\n'.format(label,basepath)
      graphics += 'Graphics_{}:\n#incbin "{}.img.bin"\n'.format(label,basepath)
      palettes += 'Pal_{}:\n#incbin "{}.pal.bin"\n'.format(label,basepath)
    frames += 'SHORT {} {}\n'.format(num, duration)
    tsalist += 'POIN TSA_{}\n'.format(label)
    graphicslist += 'POIN Graphics_{}\n'.format(label)
    paletteslist += 'POIN Pal_{}\n'.format(label)

  output = """//Generated with Skill Animation Creator.

#incbin skillanimtemplate.dmp
POIN Frames
POIN TSAList
POIN GraphicsList
POIN PalettesList
WORD 0x3d1 //sound id

{0}{1}
{2}
{3}
{4}
{5}
{6}
{7}""".format(frames,frame_end,tsalist,graphicslist,paletteslist,tsa,graphics,palettes)
  with open(outputpath,'w') as outfile:
    outfile.write(output)

if __name__ == '__main__':
  main()
