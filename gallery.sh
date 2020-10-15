#!/bin/bash

INCLUDE_TEMPLATE="
\\begin{figure}[!ht]
\\centering
\\includestandalone{#LOC}
\\caption{#NAME}
\\end{figure}"

OUTPUTNAME=gallery

echo "
\\documentclass[a4paper,12pt]{article}
    
\\usepackage[top=1.5cm, bottom=1.5cm,left=1.5cm,right=1.5cm]{geometry}
\\usepackage{graphicx}
\\usepackage[maxfloats=256]{morefloats}
\\maxdeadcycles=1000

\\usepackage{t1enc}
\\usepackage[utf8]{inputenc}
\\usepackage[magyar]{babel}
\\usepackage{caption}
\\usepackage{subcaption}

\\usepackage{standalone}
\\usepackage{tikz}
\\usepackage{alphalph}
\\usetikzlibrary{positioning, graphs}
\\usetikzlibrary{graphs.standard}
\\usetikzlibrary{patterns}
\\usetikzlibrary{arrows.meta}
\\usetikzlibrary{decorations.pathmorphing,shapes}

\\usepackage{amssymb}
\\usepackage{amsmath}

\\begin{document}
" > tmp.tex

for fname in grafok/*.tex
do
    caption=$(basename ${fname} | sed -e "s/_/\\\\\\\\\\\\_/g")
    loc=$(basename ${fname} .tex)
    echo $INCLUDE_TEMPLATE | sed "s|#LOC|grafok/${loc}|g" | sed "s|#NAME|${caption}|g" >> tmp.tex
done

echo "\\end{document}" >> tmp.tex

pdflatex -output-directory=output -jobname=${OUTPUTNAME} tmp.tex > /dev/null

rm tmp.tex output/${OUTPUTNAME}.{aux,log}