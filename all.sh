#!/usr/bin/env bash
#
# Este script se encarga de invocar los tres programas que permiten la 
# conversion de un PNG a secuencia de pixeles, se procesan esos pixeles y
# posteriormente se convierte esa secuencia de pixeles a un archivo en formato
# PNG
#
# Autor: John Sanabria - john.sanabria@correounivalle.edu.co
# Fecha: 2024-08-22
#

IMAGE_PATH="./imagenes"

for INPUT_JPG in ${IMAGE_PATH}/*.jpg; do
  TEMP_FILE="${INPUT_JPG%.jpg}.bin"
  python3 fromPNG2Bin.py ${INPUT_JPG}
  WIDTH=$(python3 -c "from PIL import Image; img = Image.open('${INPUT_JPG}'); print(img.width)")
  HEIGHT=$(python3 -c "from PIL import Image; img = Image.open('${INPUT_JPG}'); print(img.height)")
  ./main ${TEMP_FILE} ${WIDTH} ${HEIGHT}
  python3 fromBin2PNG.py ${TEMP_FILE}.new ${WIDTH} ${HEIGHT}
done
