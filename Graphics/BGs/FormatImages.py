from pathlib import Path
from PIL import Image
import re
import shutil
import os 
import unicodedata

# Function to clean filenames but keep extensions intact
def clean_name(name):
    # Extract the file extension
    name_without_extension, extension = Path(name).stem, Path(name).suffix
    
    # Normalize the name to remove accents
    name_without_extension = unicodedata.normalize('NFD', name_without_extension)  # Decompose characters into base + accent
    name_without_extension = ''.join([c for c in name_without_extension if unicodedata.category(c) != 'Mn'])  # Remove accents
    
    # Remove unwanted characters: (), {}, [], , - spaces, %, ', !, and .
    cleaned_name = re.sub(r"[()\[\]{}\,\-\s%!'\".]", "", name_without_extension)
    
    # Return cleaned name with the original extension
    return cleaned_name + extension


i = 0

def process_folder(folder):
    # Define input and output folders
    originals_folder = Path(folder)
    data_folder = Path("data")
    data_folder.mkdir(exist_ok=True)  # Ensure output folder exists
    i = 0

    # Process images with multiple extensions
    for img_path in originals_folder.glob("*"):
        if img_path.suffix.lower() not in {".png", ".jpg", ".jpeg", ".avif"}:
            continue  # Skip unsupported file types

        # Clean filename and create output path
        clean_filename = clean_name(img_path.stem) + ".png"
        output_path = data_folder / clean_filename

        if output_path.exists():
            # Get the last modified times
            original_mtime = img_path.stat().st_mtime
            destination_mtime = output_path.stat().st_mtime

            # If the original image is newer, overwrite it
            if original_mtime <= destination_mtime:
                i += 1
                continue  # Skip processing if the destination is newer or the same
        

        print(f"Processing {clean_filename}.")
        with Image.open(img_path) as img:
            width, height = img.size
            target_aspect = 3 / 2  # 3:2 aspect ratio

            # Determine cropping dimensions
            current_aspect = width / height
            if current_aspect > target_aspect:
                # Too wide: crop width
                new_width = int(height * target_aspect)
                left = (width - new_width) // 2
                right = left + new_width
                top, bottom = 0, height
            else:
                # Too tall: crop height
                new_height = int(width / target_aspect)
                top = (height - new_height) // 2
                bottom = top + new_height
                left, right = 0, width

            # Crop to 3:2 aspect ratio
            img = img.crop((left, top, right, bottom))

            # Resize to 240x160
            img = img.resize((240, 160), Image.LANCZOS)

            new_img = Image.new("RGB", (256, 160), (0, 0, 0))  # Black background
            # Paste the resized image onto the new image (top-left corner)
            new_img.paste(img, (0, 0))
            # Quantize down to 224 colors
            new_img = new_img.convert("P", palette=Image.ADAPTIVE, colors=224)

            # Clean filename
            clean_filename = clean_name(img_path.stem) + ".png"
            # Save to data folder as PNG
            output_path = data_folder / clean_filename
            new_img.save(output_path, format="PNG")
    return i

i += process_folder("img")
i += process_folder("img2")
print(f"Skipped {i} images that have not been modified since last processed.")
print("Processing complete!")
