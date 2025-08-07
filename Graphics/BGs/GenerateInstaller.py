from PIL import Image
from pathlib import Path
import shutil

# Find all .png files recursively in the `data` folder
png_files = list(Path("data").rglob("*.png"))

# Initialize counter
c = 0

# Store BGEntry lines separately to write them at the start
bg_entries = []
incbin_lines = []
definitions_lines = []

for png_file in png_files:
    # Extract file path and name information
    bg_path = png_file
    base_name = bg_path.stem  # Keep original filename
    relative_path = bg_path.parent

    # Normalize paths to use forward slashes
    normalized_relative_path = relative_path.as_posix()

    # Store BGEntry line to write at the beginning
    bg_entries.append(f"BGEntry({base_name}_BGData, {base_name}_BGPal)")

    # Store #incbin directives to write later
    incbin_lines.append("ALIGN 4")
    incbin_lines.append(f"{base_name}_BGData:")
    incbin_lines.append(f'#incbin "{normalized_relative_path}/{base_name}.dmp"')
    incbin_lines.append("ALIGN 4")
    incbin_lines.append(f"{base_name}_BGPal:")
    incbin_lines.append(f'#incbin "{normalized_relative_path}/{base_name}Pal.dmp"')

    # Define mug ID if not already defined
    definitions_lines.append(f"#ifndef {base_name}_BG\n  #define {base_name}_BG (FirstBG_ID+{c})\n#endif\n")

    # Increment the counter
    c += 1

# Append total count to the end
incbin_lines.append("\nALIGN 12\nMaxBGID:\nWORD {}\n".format(c - 1))  # c-1
# alternate if we want to randomize with vanilla ones too :
# incbin_lines.append("\nALIGN 12\nMaxBGID:\nWORD FirstBG_ID+{}\n".format(c - 1))  # c-1

# Write to the installer file
with open("Generated.event", "w") as installer:
    bg_entries.append("\nALIGN 12\nWORD 0xFFFFFFFF // Febuilder terminator \n")
    
    # Write header
    installer.write("//Generated! Do not edit!\n\n")

    # Write all BGEntry lines first
    installer.write("\n".join(bg_entries) + "\n\n")

    # Write all #incbin directives afterward
    installer.write("\n".join(incbin_lines) + "\n")
with open("GeneratedDefinitions.event", "w") as definitions:
    definitions.write("//Generated! Do not edit!\n\n")
    definitions.write("\n".join(definitions_lines) + "\n\n")

print("done")
