#!/usr/bin/env python3
"""Convert a QEMU PPM framebuffer dump to a standards-compliant PNG."""

from __future__ import annotations

import argparse
from pathlib import Path

from PIL import Image


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("source", type=Path)
    parser.add_argument("destination", type=Path)
    args = parser.parse_args()
    with Image.open(args.source) as image:
        image.convert("RGB").save(args.destination, "PNG")


if __name__ == "__main__":
    main()
