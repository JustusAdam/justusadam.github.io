#!/usr/bin/env python3
"""Generate thumbnail images for posters listed in data/projects.yaml."""

import os
import shutil
import subprocess
import sys
import tomllib
from pathlib import Path

SITE_ROOT = Path(__file__).parent.parent
STATIC = SITE_ROOT / "static"
THUMBS_DIR = STATIC / "poster-thumbs"
RESOLUTION = 150
THUMB_WIDTH = 400
BREW_PATHS = ["/opt/homebrew/bin", "/usr/local/bin"]


def find_bin(name: str) -> str | None:
    search = ":".join(BREW_PATHS + os.environ.get("PATH", "").split(":"))
    return shutil.which(name, path=search)


def generate_thumb(pdf_path: Path, out_path: Path) -> bool:
    pdftoppm = find_bin("pdftoppm")
    if pdftoppm:
        tmp = out_path.with_suffix("")
        result = subprocess.run(
            [pdftoppm, "-jpeg", "-r", str(RESOLUTION), "-f", "1", "-l", "1",
             str(pdf_path), str(tmp)],
            capture_output=True,
        )
        generated = tmp.parent / f"{tmp.name}-1.jpg"
        if result.returncode == 0 and generated.exists():
            generated.rename(out_path)
            return True

    convert = find_bin("convert")
    if convert:
        result = subprocess.run(
            [convert, f"-density{RESOLUTION}", f"{pdf_path}[0]",
             "-resize", f"{THUMB_WIDTH}x", str(out_path)],
            capture_output=True,
        )
        return result.returncode == 0

    print("ERROR: neither pdftoppm nor ImageMagick convert found", file=sys.stderr)
    print("Install one: brew install poppler  OR  brew install imagemagick", file=sys.stderr)
    return False


def main():
    with open(SITE_ROOT / "data" / "projects.toml", "rb") as f:
        projects = tomllib.load(f)["projects"]

    THUMBS_DIR.mkdir(parents=True, exist_ok=True)

    for project in projects:
        poster = project.get("poster")
        if not poster:
            continue

        key = project["key"]
        pdf_path = STATIC / poster
        out_path = THUMBS_DIR / f"{key}.jpg"

        if not pdf_path.exists():
            print(f"SKIP {key}: {pdf_path} not found")
            continue

        if out_path.exists():
            print(f"SKIP {key}: thumbnail already exists at {out_path.relative_to(SITE_ROOT)}")
            continue

        print(f"Generating thumbnail for {key} ... ", end="", flush=True)
        if generate_thumb(pdf_path, out_path):
            print(f"ok → {out_path.relative_to(SITE_ROOT)}")
        else:
            print("FAILED")


if __name__ == "__main__":
    main()
