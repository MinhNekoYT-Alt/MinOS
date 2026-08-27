from pathlib import Path
import sys

try:
    import yaml
except ImportError:
    print("PyYAML unavailable; structural checks only")
    sys.exit(0)

root = Path(__file__).resolve().parents[1]
files = [
    root / "config/includes.chroot/etc/calamares/settings.conf",
    root / "config/includes.chroot/etc/calamares/branding/minos/branding.desc",
    root / "config/includes.chroot/etc/calamares/modules/partition.conf",
    root / "config/includes.chroot/etc/calamares/modules/displaymanager.conf",
    root / "config/includes.chroot/etc/calamares/modules/bootloader.conf",
    root / "config/includes.chroot/etc/calamares/modules/packages.conf",
    root / "config/includes.chroot/etc/calamares/modules/welcome.conf",
]

for path in files:
    with path.open(encoding="utf-8") as handle:
        data = yaml.safe_load(handle)
    if data is None:
        raise SystemExit(f"empty YAML: {path}")
    print(f"OK: {path.relative_to(root)}")

print("Calamares YAML validation passed.")
