#!/bin/bash

# Pasta onde estão os arquivos
DIR="textos"

# Número de arquivos por lote
BATCH_SIZE=70

# Lista arquivos que não estão no Git ainda
files=$(git ls-files --others --exclude-standard "$DIR" | tr '\n' '\0')

# Contador
count=0
batch=()

# Processa os arquivos
while IFS= read -r -d '' file; do
    batch+=("$file")
    count=$((count + 1))

    if [ "$count" -eq "$BATCH_SIZE" ]; then
        echo "Adicionando lote de $BATCH_SIZE arquivos..."
        git add "${batch[@]}"
        batch=()
        count=0
    fi
done <<< "$files"

# Adiciona arquivos restantes (se houver)
if [ "$count" -gt 0 ]; then
    echo "Adicionando últimos $count arquivos..."
    git add "${batch[@]}"
fi

echo "Todos os arquivos processados."
