f = open("output.txt", "w")
f.write("")
f.close()
f = open("output.txt", "a")
f.write("")

filepath = 'test.txt'
with open(filepath) as fp:
   for cnt, line in enumerate(fp):
       f.write("ALIGN 4\r")
       f.write("{}ObjData:\r".format(line.rstrip()))
       f.write("#incbin \"TilesetsB/{}.dmp\"\r\r".format(line.rstrip()))

       f.write("ALIGN 4\r")
       f.write("{}PalData:\r".format(line.rstrip()))
       f.write("#incbin \"TilesetsB/{}_pal.dmp\"\r\r".format(line.rstrip()))

       f.write("ALIGN 4\r")
       f.write("{}ConfigData:\r".format(line.rstrip()))
       f.write("#incbin \"TilesetsB/{}_comp.dmp\"\r\r\r\r".format(line.rstrip()))
       
       # print("Line {}: {}".format(cnt, line))


#ViridianForestSConfigData:
#incbin "Tilesets/ViridianForestSouth_comp.dmp"



f.close()
