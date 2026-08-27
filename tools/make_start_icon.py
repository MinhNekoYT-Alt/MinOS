from collections import deque
from pathlib import Path
from PIL import Image

root = Path(__file__).resolve().parents[1]
src = root / "assets" / "minos-start-icon.png"
icon_root = root / "config" / "includes.chroot" / "usr" / "share" / "icons" / "MinOS"
pixmap = root / "config" / "includes.chroot" / "usr" / "share" / "pixmaps" / "minos-start-icon.png"

source = Image.open(src).convert("RGB")
width, height = source.size
pixels = source.load()
mask = Image.new("1", source.size, 0)
mask_pixels = mask.load()
queue = deque()
seen = set()

# Remove the light checkerboard connected to the canvas edges.
def is_background(x, y):
    r, g, b = pixels[x, y]
    return max(r, g, b) - min(r, g, b) <= 12 and (r + g + b) / 3 >= 175

for x in range(width):
    queue.append((x, 0))
    queue.append((x, height - 1))
for y in range(height):
    queue.append((0, y))
    queue.append((width - 1, y))

while queue:
    x, y = queue.popleft()
    if (x, y) in seen or not (0 <= x < width and 0 <= y < height):
        continue
    seen.add((x, y))
    if not is_background(x, y):
        continue
    mask_pixels[x, y] = 1
    queue.extend(((x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)))

rgba = source.convert("RGBA")
alpha = rgba.getchannel("A")
alpha.paste(0, mask=mask)
rgba.putalpha(alpha)
bbox = rgba.getchannel("A").getbbox()
if bbox is None:
    raise RuntimeError("Start icon subject was not detected")

subject = rgba.crop(bbox)
size = max(subject.size)
canvas = Image.new("RGBA", (size, size), (0, 0, 0, 0))
canvas.alpha_composite(subject, ((size - subject.width) // 2, (size - subject.height) // 2))

for px in (16, 22, 32, 48, 64, 128):
    target = icon_root / f"{px}x{px}" / "apps" / "start-here.png"
    canvas.resize((px, px), Image.Resampling.LANCZOS).save(target, "PNG", optimize=True)

# A scalable fallback filename is provided as a high-resolution PNG; Plasma accepts
# raster icon fallbacks from the icon theme even when no SVG is available.
scalable = icon_root / "scalable" / "apps" / "start-here.png"
canvas.resize((256, 256), Image.Resampling.LANCZOS).save(scalable, "PNG", optimize=True)
canvas.resize((256, 256), Image.Resampling.LANCZOS).save(pixmap, "PNG", optimize=True)
print(pixmap)
