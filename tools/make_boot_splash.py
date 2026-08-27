#!/usr/bin/env python3
"""Generate MinOS BIOS mascot-only splash and GRUB wallpaper splash."""
from pathlib import Path

from PIL import Image, ImageOps


ROOT = Path(__file__).resolve().parents[1]
MASCOT_PATH = ROOT / "assets" / "minos-penguin-only.png"
WALLPAPER_PATH = ROOT / "assets" / "minos-wallpaper.png"
ISOLINUX_SPLASH = ROOT / "config" / "includes.binary" / "isolinux" / "splash.png"
SYSLINUX_SPLASH = ROOT / "config" / "includes.binary" / "syslinux" / "splash.png"
GRUB_SPLASH = ROOT / "config" / "binary_grub" / "splash.tga"


def render_bios(mascot: Image.Image, size: tuple[int, int], max_logo: int) -> Image.Image:
    canvas = Image.new("RGBA", size, (5, 13, 28, 255))
    subject = mascot.copy()
    subject.thumbnail((max_logo, max_logo), Image.Resampling.LANCZOS)
    x = (size[0] - subject.width) // 2
    y = (size[1] - subject.height) // 2
    canvas.alpha_composite(subject, (x, y))
    return canvas


def main() -> None:
    mascot = Image.open(MASCOT_PATH).convert("RGBA")
    bbox = mascot.getchannel("A").getbbox()
    if bbox is None:
        raise RuntimeError("MinOS penguin mascot was not detected")
    mascot = mascot.crop(bbox)

    ISOLINUX_SPLASH.parent.mkdir(parents=True, exist_ok=True)
    SYSLINUX_SPLASH.parent.mkdir(parents=True, exist_ok=True)
    GRUB_SPLASH.parent.mkdir(parents=True, exist_ok=True)

    render_bios(mascot, (640, 480), 310).convert("RGB").save(ISOLINUX_SPLASH, "PNG", optimize=True)
    render_bios(mascot, (640, 480), 310).convert("RGB").save(SYSLINUX_SPLASH, "PNG", optimize=True)
    ImageOps.fit(Image.open(WALLPAPER_PATH).convert("RGB"), (1024, 768), Image.Resampling.LANCZOS).save(GRUB_SPLASH, "TGA")

    print(ISOLINUX_SPLASH)
    print(SYSLINUX_SPLASH)
    print(GRUB_SPLASH)


if __name__ == "__main__":
    main()
