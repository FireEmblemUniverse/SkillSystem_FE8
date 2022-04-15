import sys

import libimagequant as liq
import png


def main(argv):
    if len(argv) < 2:
        print('Please specify a path to a PNG file', file=sys.stderr)
        return 1

    input_png_file_path = argv[1]

    # Load PNG file and decode it as raw RGBA pixels
    # This uses the PyPNG library for PNG reading (not part of libimagequant)

    reader = png.Reader(filename=input_png_file_path)
    width, height, input_rgba_pixels, info = reader.read_flat()

    # Use libimagequant to make a palette for the RGBA pixels

    attr = liq.Attr()
    input_image = attr.create_rgba(input_rgba_pixels, width, height, info.get('gamma', 0))

    result = input_image.quantize(attr)

    # Use libimagequant to make new image pixels from the palette

    result.dithering_level = 1.0

    raw_8bit_pixels = result.remap_image(input_image)
    palette = result.get_palette()

    # Save converted pixels as a PNG file
    # This uses the PyPNG library for PNG writing (not part of libimagequant)
    writer = png.Writer(input_image.width, input_image.height, palette=palette)

    output_png_file_path = 'quantized_example.png'
    with open(output_png_file_path, 'wb') as f:
        writer.write_array(f, raw_8bit_pixels)

    print('Written ' + output_png_file_path)

    # Done.

main(sys.argv)
