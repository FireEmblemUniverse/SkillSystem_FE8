# Run this to create 64 different palettes
# each containing 1 white colour followed by
# 15 shades of their main colour ordered from dark to light.
# This is achieved by incrementally increasing the hue for each palette.
# The palettes will be APPENDED to TitleBGPalettes.dmp in the format that FEGBA should accept.
import colorsys

# Function is a modified version of this one: http://www.herethere.net/~samson/php/color_gradient/color_gradient_generator.php.txt
def interpolate(pBegin, pEnd, pStep, pMax):
    if (pBegin < pEnd):
        return ((pEnd - pBegin) * (pStep / pMax)) + pBegin
    else:
        return ((pBegin - pEnd) * (1 - (pStep / pMax))) + pEnd

# Function taken from martineau's answer: https://stackoverflow.com/questions/54116198/how-to-convert-int-to-hex-and-write-hex-to-file
def int_to_bytes(n, minlen=0):
    """ Convert integer to bytearray with optional minimum length. 
    """
    if n > 0:
        arr = []
        while n:
            n, rem = n >> 8, n & 0xff
            arr.append(rem)
        b = bytearray(reversed(arr))
    elif n == 0:
        b = bytearray(b'\x00')
    else:
        raise ValueError('Only non-negative values supported')

    if minlen > 0 and len(b) < minlen: # zero padding needed?
        b = (minlen-len(b)) * '\x00' + b
    return b

def main():
    steps = 15
    gradientR = [0 for x in range(steps)]
    gradientG = [0 for x in range(steps)]
    gradientB = [0 for x in range(steps)]
    r = [0 for x in range(7)]
    g = [0 for x in range(7)]
    b = [0 for x in range(7)]
    palette = [0 for x in range(steps+1)]
    palette[0] = hex(0xff7f) # white, transparent colour
    paletteStringBegin = "ff7f"
    
    # colour1
    hsv = colorsys.rgb_to_hsv(31/31, 21/31, 8/31)
    rgb = colorsys.hsv_to_rgb(0, hsv[1], hsv[2])
    r[0] = rgb[0]
    g[0] = rgb[1]
    b[0] = rgb[2]
    
    # colour2
    hsv = colorsys.rgb_to_hsv(31/31, 27/31, 29/31)
    rgb = colorsys.hsv_to_rgb(0, hsv[1], hsv[2])
    r[1] = rgb[0]
    g[1] = rgb[1]
    b[1] = rgb[2]
    
    # colour3
    hsv = colorsys.rgb_to_hsv(30/31, 26/31, 25/31)
    rgb = colorsys.hsv_to_rgb(0, hsv[1], hsv[2])
    r[2] = rgb[0]
    g[2] = rgb[1]
    b[2] = rgb[2]
    
    # colour4
    hsv = colorsys.rgb_to_hsv(29/31, 15/31, 14/31)
    rgb = colorsys.hsv_to_rgb(0, hsv[1], hsv[2])
    r[3] = rgb[0]
    g[3] = rgb[1]
    b[3] = rgb[2]
    
    # colour5
    hsv = colorsys.rgb_to_hsv(29/31, 19/31, 18/31)
    rgb = colorsys.hsv_to_rgb(0, hsv[1], hsv[2])
    r[4] = rgb[0]
    g[4] = rgb[1]
    b[4] = rgb[2]
    
    # colour6
    hsv = colorsys.rgb_to_hsv(28/31, 13/31, 11/31)
    rgb = colorsys.hsv_to_rgb(0, hsv[1], hsv[2])
    r[5] = rgb[0]
    g[5] = rgb[1]
    b[5] = rgb[2]
    
    # colour7
    hsv = colorsys.rgb_to_hsv(27/31, 10/31, 10/31)
    rgb = colorsys.hsv_to_rgb(0, hsv[1], hsv[2])
    r[6] = rgb[0]
    g[6] = rgb[1]
    b[6] = rgb[2]
    
    print(rgb)
    

    f = open("VersusBGPalettes.dmp", "ab")
    for i in range(64):
        
        gradientRInt = [int(x*31 + 0.5) for x in r]
        gradientGInt = [int(x*31 + 0.5) for x in g]
        gradientBInt = [int(x*31 + 0.5) for x in b]
        
        # Turn palette into string
        paletteString = paletteStringBegin
        for k in range(len(gradientRInt)):
            palette[k+1] = hex((gradientRInt[k] << 10) | (gradientGInt[k] << 5) | (gradientBInt[k]))
            
            # Add zeroes if hexdigitcount under four
            colourString = (str(palette[k+1])[2:6])
            while len(colourString) < 4:
                colourString = "0" + colourString
                
            # Endian BS
            colourString = colourString[2] + colourString[3] + colourString[0] + colourString[1]
            
            paletteString += str(colourString)
            
        paletteString += "0925" # Gray
        paletteString += "0000000000000000000000000000" # Black and unused colours
            
        print(paletteString)
        
        # Write palette to file
        paletteHex = int(paletteString, 16)
        f.write(int_to_bytes(paletteHex))
        
        # Shift hue
        for l in range(7):
            hsv = colorsys.rgb_to_hsv(r[l], g[l], b[l])
            hue = hsv[0] + 1/64
            rgb = colorsys.hsv_to_rgb(hue, hsv[1], hsv[2])
            r[l] = rgb[0]
            g[l] = rgb[1]
            b[l] = rgb[2]
        
    f.close()
    
            
main()
