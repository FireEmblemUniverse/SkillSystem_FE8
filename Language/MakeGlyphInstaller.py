import os, sys, glob, codecs, shutil
from PIL import Image
import numpy as np
import Png2Font
#		python MakeGlyphInstaller.py FE8U.gba

# 读取字模长度
def GetGlyphLen(img):
		
	for i in range(15, 0, -1):
		for j in range(0, 15):
			if 0 != img[j, i]:
				return i
	
	return 0




def InitInstaller(installer_dir):
	
	
	
	font_installer = installer_dir + "/FontInstaller.event"
	main_installer = installer_dir + "/../FE8U-CN-Font-Installer.event"
	config_file = installer_dir + "/InstallConfig.event"
	debug_text = installer_dir + "/Debug_Text.txt"
	
	# remove existing files
	if os.path.exists(config_file):
		os.remove(config_file)
	
	if os.path.exists(main_installer):
		os.remove(main_installer)
	
	if os.path.exists(font_installer):
		os.remove(font_installer)
	
	if os.path.exists(debug_text):
		os.remove(debug_text)
	
	
	# make debug text
	with codecs.open(debug_text, 'w', encoding='utf-8') as fp:
		fp.write("悠木")
	
	# init config file
	with open(config_file, 'w') as fp_config:
		fp_config.write("// conig file\n")
		
		
	# make main file
	with open(main_installer, 'w') as fp_main:
		
		fp_main.write("\nPUSH\n\n")
		fp_main.write("// #define __DEBUG__\n\n\n")
		
		fp_main.write("// Start of font glyphes space\n")
		fp_main.write("#ifndef FreeSpaceFont\n")
		fp_main.write("\t#define FreeSpaceFont  $EFB2E0	// End: $FE0000; size E4D20\n")
		fp_main.write("\t#define FreeSpaceFontEnd 0xFE0000\n")
		fp_main.write("#endif // FreeSpaceFont\n")
		fp_main.write("\n\n\n")
		
		fp_main.write("ORG FreeSpaceFont\n")
		fp_main.write("\t#include \"FontInstaller/FontPatches.event\"\n")
		fp_main.write("\t#include \"FontInstaller/FontTableDef.event\"\n")
		fp_main.write("\t#include \"FontInstaller/InstallConfig.event\"\n")
		fp_main.write("\t#include \"FontInstaller/FontInstaller.event\"\n")
		fp_main.write("\n\n\n")
		
		fp_main.write("#ifdef __DEBUG__\n\n")
		fp_main.write("\t// replace Eirika's name as \"\"\n\n")
		fp_main.write("\t#include \"Tools/Tool Helpers.txt\"\n")
		fp_main.write("\tsetText(0x212, NameMokha)\n")
		fp_main.write("\n")
		
		fp_main.write("\tALIGN 4\n")
		fp_main.write("\tNameMokha:\n")
		fp_main.write("\t\t#incbin \"FontInstaller/Debug_Text.txt\"\n")
		fp_main.write("\t\tBYTE 0\n")
		fp_main.write("\t\tALIGN 4\n")
		fp_main.write("\n")
		
		fp_main.write("#endif // __DEBUG__\n")
		fp_main.write("\n\n\n")
		
		fp_main.write("#ifdef FreeSpaceFontEnd\n")
		fp_main.write("\tASSERT (FreeSpaceFontEnd - CURRENTOFFSET)\n")
		fp_main.write("#endif // FreeSpaceFontEnd\n")
		fp_main.write("\nPOP\n\n")
		
	with open(font_installer, 'w') as fp_font:
		
		fp_font.write("#define Fonts(UTFlow, width) \"ALIGN 4; PUSH; ORG CURRENTOFFSET-0x48; POIN CURRENTOFFSET+0x48; POP; WORD $0; BYTE UTFlow width 0 0\"\n")
		
		

		for i in range(0x100):
			fp_font.write("#ifdef ___Item_"+ "{:04X}".format(i) + "_\n")
			fp_font.write("\tALIGN 4\n")
			fp_font.write("\tWORD 0 0 0 0\n")
			fp_font.write("\tWORD 0 0 0 0\n")
			fp_font.write("\tWORD 0 0 0 0\n")
			fp_font.write("\tWORD 0 0 0 0\n")
			fp_font.write("\tWORD 0 0 0 0\n")
			fp_font.write("\tItem_" + "{:04X}".format(i) + "_Next:\n")
			fp_font.write("\t#include \"Item_" + "{:04X}".format(i) + "_.event\"\n")
			fp_font.write("#endif\n\n")
			
			fp_font.write("#ifdef ___Text_"+ "{:04X}".format(i) + "_\n")
			fp_font.write("\tALIGN 4\n")
			fp_font.write("\tWORD 0 0 0 0\n")
			fp_font.write("\tWORD 0 0 0 0\n")
			fp_font.write("\tWORD 0 0 0 0\n")
			fp_font.write("\tWORD 0 0 0 0\n")
			fp_font.write("\tWORD 0 0 0 0\n")
			fp_font.write("\tText_" + "{:04X}".format(i) + "_Next:\n")
			fp_font.write("\t#include \"Text_" + "{:04X}".format(i) + "_.event\"\n")
			fp_font.write("#endif\n\n")
		
		
		fp_font.write("PUSH\n")
		
		for i in range(0x100):
			fp_font.write("#ifdef ___Item_"+ "{:04X}".format(i) + "_\n")
			fp_font.write("\tORG Item_" + "{:04X}".format(i) + "_ORG_\n")
			fp_font.write("\tPOIN Item_" + "{:04X}".format(i) + "_Next\n")
			fp_font.write("#endif\n\n")
			
			fp_font.write("#ifdef ___Text_"+ "{:04X}".format(i) + "_\n")
			fp_font.write("\tORG Text_" + "{:04X}".format(i) + "_ORG_\n")
			fp_font.write("\tPOIN Text_" + "{:04X}".format(i) + "_Next\n")
			fp_font.write("#endif\n\n")

		fp_font.write("POP\n")


def AppendFontInstaller(glyph_file, installer_dir):
	
	
	glyph_file_name = os.path.basename(glyph_file)
	name_wo_ext = os.path.splitext(glyph_file_name)[0]
	glyth_type = glyph_file_name[4:8]
	glyth_name = glyph_file_name[8]
	glyth_name_uni = ord(glyth_name)
	glyth_img = Png2Font.GetImgArray(glyph_file)
	
	installer_file = installer_dir + "/" + glyth_type + \
		"_" + "{:04X}".format(0xFF & glyth_name_uni) + "_.event"

	if not os.path.exists(installer_file):
		with open(installer_file, 'w') as fp:
			fp.write("// Sub Font Installer\n")
	
	with codecs.open(installer_file, 'a', encoding='utf-8') as fp:
		
		glyph_len = GetGlyphLen(glyth_img)
		
		if "Text" == glyth_type:
			glyph_len = glyph_len + 1
		
		fp.write("ALIGN 4\n")
		fp.write("Fonts(0x" + "{:04X}".format(0xFF & (glyth_name_uni>>8)) + ", " + str(glyph_len) + ")\n")
		fp.write("\t#incbin \"../FontData/" + name_wo_ext + ".fefont\"\n")
		fp.write("\n")
		
	
	if glyth_type == "Item":
		return 0x100 + (0xFF & glyth_name_uni)
	else:
		return (0xFF & glyth_name_uni)
	


def MakeFontTable(gba_file, table_file):
	(input_name, input_ext) = os.path.splitext(gba_file)
	
	if not ".gba" == input_ext:
		sys.exit("please input a gba file to make FontTable!")

	if os.path.exists(table_file):
		os.remove(table_file)
	
	
	FontTableItemAt = 0x58C7EC;
	FontTableTextAt = 0x58F6F4;
	
	FontItemTable = np.fromfile(
		gba_file, 
		dtype = np.uint8, 
		count = 0x400,
		offset = FontTableItemAt,
		)
	
	FontTextTale = np.fromfile(
		gba_file, 
		dtype = np.uint8, 
		count = 0x400,
		offset = FontTableTextAt
		)
	
	
	with open(table_file, 'w') as fp_table:
		
		fp_table.write("#ifndef FONTTABLE_DEF\n")
		fp_table.write("#define FONTTABLE_DEF\n")
		fp_table.write("\n")
		fp_table.write("#define gpFontTableItem 0x058C7EC\n")
		fp_table.write("#define gpFontTableText 0x058F6F4\n")
		fp_table.write("\n")
		
		
		for i in range(0x100):
			
			
			# Item Table
			ptr = 0 \
				+ FontItemTable[4 * i + 0] \
				+ FontItemTable[4 * i + 1] * 0x100 \
				+ FontItemTable[4 * i + 2] * 0x10000 \
			#	+ FontItemTable[4 * i + 3] * 0x1000000
			
			
			if 0 == ptr:
				ptr = FontTableItemAt + 4 * i

			
			fp_table.write(
				"#define Item_" + 
				"{:04X}".format(i) + 
				"_ORG_ 0x" + 
				"{:08X}".format( ptr ) + 
				"\n")
		
			# Text Table
			ptr = 0 \
				+ FontTextTale[4 * i + 0] \
				+ FontTextTale[4 * i + 1] * 0x100 \
				+ FontTextTale[4 * i + 2] * 0x10000 \
			#	+ FontTextTale[4 * i + 3] * 0x1000000
			
			if 0 == ptr:
				ptr = FontTableTextAt + 4 * i

			
			fp_table.write(
				"#define Text_" + 
				"{:04X}".format(i) + 
				"_ORG_ 0x" + 
				"{:08X}".format( ptr ) + 
				"\n")
			
			
		fp_table.write("#endif // FONTTABLE_DEF\n")


def MakeCnFontPatches(patch_file):
	if os.path.exists(patch_file):
		os.remove(patch_file)
	
	with open(patch_file, 'w') as fp:
		fp.write("\n")
		fp.write("#define jumpToHack_r1(offset) \"BYTE 0x00 0x49 0x08 0x47; POIN (offset|0x1)\"\n")
		fp.write("#include \"Extensions/Hack Installation.txt\"\n")
		fp.write("#include \"EAstdlib.event\"\n")
		fp.write("#include \"Tools/Tool Helpers.txt\"\n\n")
		
		fp.write("PUSH\n")
		fp.write("{\n")
		fp.write("\t//Anti-Huffman Patch, by Hextator and Nintenlord\n")
		fp.write("\tORG 0x2BA4 //Pointer Tester\n")
		fp.write("\t\tBYTE 0x00 0xB5 0xC2 0x0F 0x02 0xD0 \n")
		fp.write("\t\tBL(uncompHelper) /*0x07 0xF0 0x63 0xFB*/\n")
		fp.write("\t\tSHORT 0xE001\n")
		fp.write("\t\tBL(compressedHelper) /*0x07 0xF0 0x58 0xFB*/\n")
		fp.write("\t\tSHORT 0xBD00\n")
		fp.write("\n")
		
		fp.write("\tORG 0xA24A\n")
		fp.write("\t\tBYTE 0x05 0xD0 0x04 0x49 0x28 0x1C 0x00 0xF0 0x16 0xF8 0x35 0x60 0x00 0xE0 0x01 0x48 0x70 0xBC 0x00 0xBD 0x00 0x00 \n")
		fp.write("\t\tWORD 0x0202A6AC\n")
		fp.write("\t\n")
		
		fp.write("\tcompressedHelper:\n")
		fp.write("\t\tSHORT 0xB500 0x4A02 0x6812\n")
		fp.write("\t\tBL(0xD18C8) //In-game unencoding routine, I assume\n")
		fp.write("\t\tSHORT 0xBD00 \n")
		fp.write("\t\tWORD 0x03004150\n")
		fp.write("\t\n")

		fp.write("\tuncompHelper:\n")
		fp.write("\t\tjumpToHack(AntiHuffmanFreeSpace) //FEditor uses r2 instead of r3, but it shouldn't matter.\n\n")
		
		fp.write("\tORG 0x464470\n")
		fp.write("\tAntiHuffmanFreeSpace: //Can be relocated as necessary.\n")
		fp.write("\t\tBYTE 0x80 0x23 0x1B 0x06 0xC0 0x1A 0x02 0x78 0x0A 0x70 0x01 0x31 0x01 0x30 0x00 0x2A 0xF9 0xD1 0x70 0x47\n")
		
		
		fp.write("\t\n\n\n\n")
		fp.write("\t// Draw-UTF8 patch\n\n")
		fp.write("\tORG $44D2\n")
		fp.write("\t\tBYTE 0x00 0x00\n")
		fp.write("\t\tjumpToHack(DrawUTF8Item)\n")
		fp.write("\t\n")
		
		fp.write("\tORG $450C\n")
		fp.write("\t\tjumpToHack(DrawUTF8Serif)\n")
		fp.write("\t\n")
		
		fp.write("\tORG $4540\n")
		fp.write("\t\tjumpToHack_r1(DrawUTF8WidthChar)\n")
		fp.write("\t\n")
		
		fp.write("\tORG $4574\n")
		fp.write("\t\tjumpToHack(DrawUTF8WidthString)\n")
		fp.write("\t\n")
		fp.write("}\n")
		fp.write("POP\n")
		fp.write("\t\n")
		fp.write("\t\n")
		fp.write("\t\n")
		
		fp.write("ALIGN 4\n")
		fp.write("UTF8_COMMON:\n")
		fp.write("\tWORD $780BB510 $D00D2B00 $DD0C2B80 $DA492BFC $DA322BF8 $DA1F2BF0 $DA102BE0 $DA052BC0 $E0753101 $780BE074 $E0543101 $4023241F $784A019B $4022243F $31024313 $240FE04B $19B4023 $243F784A $43134022 $788A019B $43134022 $E03E3103 $40232407 $784A019B $4022243F $19B4313 $4022788A $19B4313 $402278CA $31044313 $2403E02D $19B4023 $243F784A $43134022 $788A019B $43134022 $78CA019B $43134022 $790A019B $43134022 $E0183105 $40232401 $784A019B $4022243F $19B4313 $4022788A $19B4313 $402278CA $19B4313 $4022790A $19B4313 $4022794A $31064313 $61AE7FF $920E12 $480E0A1B $68406800 $28005880 $61AD012 $79040E12 $D10B42A2 $6120A1A $79840E12 $D10542A2 $6120C1A $79C40E12 $D00242A2 $E7EA6800 $4B012000 $BD10681B $2028E70\n")
		fp.write("\t\n")
		
		fp.write("ALIGN 4\n")
		fp.write("DrawUTF8Item:\n")
		fp.write("\tWORD $4B031C21 $F800469E $1C011C0C $46874801\n")
		fp.write("\tPOIN UTF8_COMMON|1\n")
		fp.write("\tWORD $80044E0\n")
		fp.write("\t\n")
		
		fp.write("ALIGN 4\n")
		fp.write("DrawUTF8Serif:\n")
		fp.write("\tWORD $4B031C21 $F800469E $1C011C0C $46874801\n")
		fp.write("\tPOIN UTF8_COMMON|1\n")
		fp.write("\tWORD $800451A\n")
		fp.write("\t\n")
		
		fp.write("ALIGN 4\n")
		fp.write("DrawUTF8WidthChar:\n")
		fp.write("\tWORD $1C11B408 $469E4B05 $1C0AF800 $D1022800 $30FC6858 $BC086800 $468F4901\n")
		fp.write("\tPOIN UTF8_COMMON|1\n")
		fp.write("\tWORD $8004558\n")
		fp.write("\t\n")
		
		fp.write("ALIGN 4\n")
		fp.write("DrawUTF8WidthString:\n")
		fp.write("\tWORD $2400B410 $469E4B05 $2800F800 $7940D002 $E7F71824 $BC101C22 $46874801\n")
		fp.write("\tPOIN UTF8_COMMON|1\n")
		fp.write("\tWORD $800458E\n")
		fp.write("\t\n")
		
		fp.write("\t\n")

		
		
		


			
			
def main():
	
	current_path = os.getcwd()
	installer_dir = current_path + "/FontInstaller"
	config_file = installer_dir + "/InstallConfig.event"
	table_file = installer_dir + "/FontTableDef.event"
	patch_file = installer_dir + "/FontPatches.event"
	
	# as input a .gba file
	if len(sys.argv) < 2:
		sys.exit("please input a gba file to make FontTable!")

	if len(sys.argv) > 2:
		MakeFontTable( sys.argv[1], table_file )
		sys.exit("only updated TableDef!")
	
	# mkdir installer folder
	if os.path.exists(installer_dir):
		shutil.rmtree(installer_dir)
		
	os.mkdir(installer_dir)
	
	
	# make file "FontTableDef.event"
	MakeFontTable( sys.argv[1], table_file )
		
		
	# make file "FontInstaller.event"
	InitInstaller(installer_dir)
	
	glyph_files = glob.glob(r'FontData/*.png')
	
	# a config array to make file "InstallConfig.event"
	config_flag = np.zeros(0x200) 
	
	for file in glyph_files:
		
		# make ".fefont" file
		Png2Font.Png2Font(file)
		
		# make "Item_00X0.event" or "Text_00X0.event"
		config_flag[ AppendFontInstaller(file, installer_dir)] = 1
	
	# make file "InstallConfig.event"
	with codecs.open(config_file, 'a', encoding='utf-8') as fp:
		for i in range(0x100):
			if config_flag[i] == 1 :
				fp.write("#define ___Text_" + "{:04X}".format(i) + "_\n")
			
			if  config_flag[i+0x100] == 1 :
				fp.write("#define ___Item_" + "{:04X}".format(i) + "_\n")
	
	
	
	# make patches
	MakeCnFontPatches(patch_file)
	
		
if __name__ == '__main__':
	main()	
