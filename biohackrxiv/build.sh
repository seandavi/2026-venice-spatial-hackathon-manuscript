#!/usr/bin/env bash
#
# Reproducibly build the BioHackrXiv preprint PDF for this manuscript.
#
# Renders paper.pdf from paper.md + paper.bib (at the repo root) using
# biohackrxiv/bhxiv-gen-pdf, pinned to a known-good upstream commit and with
# two local template patches that are required to render correctly. See
# README.md in this directory for the full background on why each patch exists.
#
# Requirements: docker + git. Works on both Apple Silicon (arm64) and amd64.
#
# Usage:  ./biohackrxiv/build.sh
# Output: ./paper.pdf
#
set -euo pipefail

# --- configuration -----------------------------------------------------------
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TOOL_URL="https://github.com/biohackrxiv/bhxiv-gen-pdf.git"
TOOL_COMMIT="db1ed730596fecb3b6544ab464460e803a23303e"   # merge of PR #47, 2025-11-27
IMAGE="biohackrxiv/gen-pdf:venice"
# The upstream Dockerfile downloads an amd64 pandoc binary, so the whole image
# must be amd64. On Apple Silicon this runs under emulation (slower but correct);
# building the stock arm64 image instead yields an "exec format error" on pandoc.
PLATFORM="linux/amd64"
PATCH="${REPO_ROOT}/biohackrxiv/latex-template.patch"

WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

# --- 1. fetch the tool at a pinned commit ------------------------------------
echo ">> Cloning bhxiv-gen-pdf @ ${TOOL_COMMIT:0:12}"
git clone --quiet "$TOOL_URL" "$WORK/tool"
git -C "$WORK/tool" checkout --quiet "$TOOL_COMMIT"

# --- 2. apply the template patches -------------------------------------------
echo ">> Applying latex-template.patch"
git -C "$WORK/tool" apply "$PATCH"

# --- 3. build the (patched) image --------------------------------------------
echo ">> Building Docker image $IMAGE ($PLATFORM) — first build installs TeX Live and takes a few minutes"
docker build --platform="$PLATFORM" -t "$IMAGE" -f "$WORK/tool/docker/Dockerfile" "$WORK/tool"

# --- 4. generate the PDF -----------------------------------------------------
# gen-pdf reads paper.md + paper.bib and resolves figure paths (figures/...)
# relative to the directory it is given, so we run it against the repo root.
echo ">> Generating paper.pdf"
docker run --rm --platform="$PLATFORM" -v "$REPO_ROOT":/work -w /work "$IMAGE" gen-pdf /work

echo ">> Done: ${REPO_ROOT}/paper.pdf"
