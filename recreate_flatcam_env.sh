#!/bin/bash

set -e

ENV_NAME="flatcam"

echo "Removing old FlatCAM environment..."
conda deactivate 2>/dev/null || true
conda env remove -n "$ENV_NAME" -y 2>/dev/null || true

echo "Creating clean Python 3.11 environment..."
conda create -n "$ENV_NAME" -c conda-forge \
    python=3.11 \
    numpy=1.26.4 \
    scipy \
    matplotlib \
    shapely=2.0 \
    gdal \
    rasterio \
    rtree \
    lxml \
    freetype-py \
    fonttools \
    pyopengl \
    pillow \
    kiwisolver \
    six \
    python-dateutil \
    cycler \
    dill \
    simplejson \
    svg.path \
    svglib \
    ezdxf \
    qrcode \
    reportlab \
    pyserial \
    pikepdf \
    pyppeteer \
    darkdetect \
    pip \
    -y

echo "Activating environment..."
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$ENV_NAME"

echo "Installing Qt..."
python -m pip install \
    "PyQt6==6.7.1" \
    "PyQt6-Qt6==6.7.1" \
    "PyQt6-sip>=13.8,<14"

echo "Installing FlatCAM-compatible VisPy..."
python -m pip install \
    "vispy==0.9.0"

echo "Installing remaining FlatCAM packages..."
python -m pip install \
    "ortools>=7.0" \
    svgtrace

echo
echo "======================================"
echo "FlatCAM environment created."
echo "======================================"
echo
echo "Versions:"
python -c "import sys, numpy, PyQt6, vispy; from PyQt6 import QtCore; print('Python:', sys.version.split()[0]); print('NumPy:', numpy.__version__); print('PyQt6:', QtCore.PYQT_VERSION_STR); print('Qt:', QtCore.QT_VERSION_STR); print('VisPy:', vispy.__version__)"
echo
echo "Start FlatCAM with:"
echo "conda activate flatcam"
echo "python flatcam.py"
