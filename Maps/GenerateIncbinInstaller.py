

##      with open(os.path.splitext(fname)[0]+".event", 'w') as myfile:
##        myfile.write(eventfile)
##      installer += "{\n#include \""+os.path.splitext(fname)[0]+".event\"\n}\n"
##
##  if create_installer:
##    with open("Master Map Installer.event", 'w') as f:
##      f.write(installer)

ChDefinitions = open("Defs/UnsortedChDefinitions.txt", 'w')
ChDefinitions.write("//Generated. Do not edit!\n") 
ChDefinitions.close()
MapDefinitions = open("Defs/MapDefinitions.txt", 'w')
MapDefinitions.write("//Generated. Do not edit!\n") 
MapDefinitions.close()

## Chapter and Map Definitions section 
import glob, os
for map_file in glob.glob("Maps/*.tmx"):
    map_file = os.path.basename(map_file).replace(" ", "")
    map_file = map_file.rsplit( ".tmx", 1 ) [ 0 ] 
    with open("Defs/MapDefinitions.txt", 'a+') as f:
      f.write(map_file)
      f.write("Map\n")
    with open("Defs/UnsortedChDefinitions.txt", 'a+') as f:
      f.write(map_file)
      f.write("Ch\n")

## Create the definition files 
ObjDefinitions = open("Defs/ObjPalDefinitions.txt", 'w')
ObjDefinitions.write("//Generated. Do not edit!\n") 
ObjDefinitions.close()
ConfDefinitions = open("Defs/ConfDefinitions.txt", 'w')
ConfDefinitions.write("//Generated. Do not edit!\n") 
ConfDefinitions.close()

InstallerDefinitions = open("GeneratedInstaller.event", 'w')
InstallerDefinitions.write("//Generated. Do not edit!\n\n") 
InstallerDefinitions.close()


## Macros 
for obj_file in glob.glob("ConfObj/*.png"):
    obj_file = os.path.basename(obj_file).replace(" ", "")
    obj_file = obj_file.rsplit( ".png", 1 ) [ 0 ] 
    with open("GeneratedInstaller.event", 'a+') as f:
       f.write("ObjTypePalettePointerTable({}Pal,".format(obj_file))
       f.write("{}PalData)\n".format(obj_file))
       
       f.write("ObjTypePalettePointerTable({}Obj,".format(obj_file))
       f.write("{}ObjData)\n".format(obj_file))

## Conf macros 
for conf_file in glob.glob("ConfObj/*.mapchip_config"):
    conf_file = os.path.basename(conf_file).replace(" ", "")
    conf_file = conf_file.rsplit( ".mapchip_config", 1 ) [ 0 ] 
    with open("GeneratedInstaller.event", 'a+') as f:
       f.write("TileConfigPointerTable({}Conf,".format(conf_file))
       f.write("{}ConfData)\n".format(conf_file))



## Incbin section
for obj_file in glob.glob("ConfObj/*.png"):
    obj_file = os.path.basename(obj_file).replace(" ", "")
    obj_file = obj_file.rsplit( ".png", 1 ) [ 0 ] 
    with open("Defs/ObjPalDefinitions.txt", 'a+') as f:
      f.write(obj_file)
      f.write("Obj\n")
      f.write(obj_file)
      f.write("Pal\n")
    with open("GeneratedInstaller.event", 'a+') as f:
    
       f.write("\rALIGN 4\r")
       f.write("{}ObjData:\r".format(obj_file.rstrip()))
       f.write("#incbin \"dmp/{}.dmp\"\r\r".format(obj_file.rstrip()))

       f.write("ALIGN 4\r")
       f.write("{}PalData:\r".format(obj_file.rstrip()))
       f.write("#incbin \"dmp/{}_pal.dmp\"\r\r".format(obj_file.rstrip()))

##import sys, subprocess
## p = subprocess.Popen('Defs/ObjPalDefinitions.txt', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
##subprocess.call(["Defs/Enumerate.bat", "Defs/ObjPalDefinitions.txt"])
##pid = subprocess.Popen([sys.executable, "Defs/ObjPalDefinitions.txt"]) # Call subprocess
##subprocess.Popen(["Defs/ObjPalDefinitions.txt", "Defs/ObjPalDefinitions.txt"] + sys.argv[1:])
## subprocess.run(["Defs/Enumerate.bat", "Defs/ObjPalDefinitions.txt"])

## ObjTypePalettePointerTable(PokecenterObj, OaksLabObjData)
## TileConfigPointerTable(PokecenterConf, OaksLabConfigData)
## ObjTypePalettePointerTable(PokecenterPal, OaksLabPalData)

## Mapchip_config 
for conf_file in glob.glob("ConfObj/*.mapchip_config"):
    conf_file = os.path.basename(conf_file).replace(" ", "")
    conf_file = conf_file.rsplit( ".mapchip_config", 1 ) [ 0 ] 
    with open("Defs/ConfDefinitions.txt", 'a+') as f:
      f.write(conf_file)
      f.write("Conf\n")

    with open("GeneratedInstaller.event", 'a+') as f:
       f.write("ALIGN 4\r")
       f.write("{}ConfData:\r".format(conf_file.rstrip()))
       f.write("#incbin \"dmp/{}_comp.dmp\"\r\r".format(conf_file.rstrip()))



## Macro section

      

##f = open("output.txt", "w")
##f.write("")
##f.close()
##f = open("output.txt", "a")
##f.write("")
##
##temp = open("temp_file.txt", "a")
##
##
##filepath = 'test.txt'
##with open(filepath) as fp:
##   for cnt, line in enumerate(fp):
##       f.write("ALIGN 4\r")
##       f.write("{}ObjData:\r".format(line.rstrip()))
##       f.write("#incbin \"TilesetsB/{}.dmp\"\r\r".format(line.rstrip()))
##
##       f.write("ALIGN 4\r")
##       f.write("{}PalData:\r".format(line.rstrip()))
##       f.write("#incbin \"TilesetsB/{}_pal.dmp\"\r\r".format(line.rstrip()))
##
##       f.write("ALIGN 4\r")
##       f.write("{}ConfigData:\r".format(line.rstrip()))
##       f.write("#incbin \"TilesetsB/{}_comp.dmp\"\r\r\r\r".format(line.rstrip()))
##       
##       # print("Line {}: {}".format(cnt, line))
##
##
###ViridianForestSConfigData:
###incbin "Tilesets/ViridianForestSouth_comp.dmp"
##
##
##
##f.close()

