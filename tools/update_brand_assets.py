#!/usr/bin/env python3
"""Prepare MinOS branding assets from user-supplied wallpaper and full logo."""
from collections import deque
from pathlib import Path

from PIL import Image


ROOT = Path(__file__).resolve().parents[1]
WALLPAPER_SOURCE = Path("/home/ubuntu/upload/9e5e34c0-a147-11f1-b059-2dc250a9bbe8(1).png")
LOGO_SOURCE = Path("/home/ubuntu/upload/7b6829d0-a147-11f1-b059-2dc250a9bbe8.png")
WALLPAPER_TARGET = ROOT / "assets" / "minos-wallpaper.png"
LOGO_TARGET = ROOT / "assets" / "minos-logo.png"
MASCOT_TARGET = ROOT / "assets" / "minos-penguin-only.png"


def edge_background_mask(image: Image.Image) -> Image.Image:
    """Return an alpha mask for bright neutral checkerboard/white edge backgrounds."""
    rgb = image.convert("RGB")
    width, height = rgb.size
    pixels = rgb.load()
    visited = set()
    queue = deque()
    alpha = Image.new("L", rgb.size, 255)
    alpha_pixels = alpha.load()

    def is_background(x: int, y: int) -> bool:
        red, green, blue = pixels[x, y]
        return max(red, green, blue) - min(red, green, blue) <= 14 and (red + green + blue) / 3 >= 170

    for x in range(width):
        queue.append((x, 0))
        queue.append((x, height - 1))
    for y in range(height):
        queue.append((0, y))
        queue.append((width - 1, y))

    while queue:
        x, y = queue.popleft()
        if (x, y) in visited or not (0 <= x < width and 0 <= y < height):
            continue
        visited.add((x, y))
        if not is_background(x, y):
            continue
        alpha_pixels[x, y] = 0
        queue.extend(((x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)))
    return alpha


def main() -> None:
    if not WALLPAPER_SOURCE.is_file() or not LOGO_SOURCE.is_file():
        raise SystemExit("User branding source images are missing.")

    wallpaper = Image.open(WALLPAPER_SOURCE).convert("RGB")
    full_logo = Image.open(LOGO_SOURCE).convert("RGB")
    wallpaper.save(WALLPAPER_TARGET, "PNG", optimize=True)
    full_logo.save(LOGO_TARGET, "PNG", optimize=True)

    mascot = full_logo.convert("RGBA")
    mascot.putalpha(edge_background_mask(full_logo))
    # The wordmark is below the mascot in the supplied square lockup.
    mascot = mascot.crop((0, 0, mascot.width, round(mascot.height * 0.72)))
    bbox = mascot.getchannel("A").getbbox()
    if bbox is None:
        raise SystemExit("Could not isolate the MinOS penguin mascot.")
    mascot.crop(bbox).save(MASCOT_TARGET, "PNG", optimize=True)

    print(f"Updated {WALLPAPER_TARGET}")
    print(f"Updated {LOGO_TARGET}")
    print(f"Created {MASCOT_TARGET}")


if __name__ == "__main__":
    main()
