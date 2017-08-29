#!/bin/bash
echo "STARTING RUNPDFTEX"
rm -f tlatex.tex
GLOBIGNORE='*supp-pdf*'
#BEGIN FILE makepdfs.sh
# loop through all .tex files
for f in *.tex ; do
    # ${f%tex} removes a trailing instance of 'tex', if one exists
    # from f.
    if test ${f} -nt ${f%tex}pdf ; then
        # run without stopping
        pdflatex <<EOF
\\nonstopmode\\input{${f}}
EOF
        # abort on the first failed run
        RETCODE=${?}
        if test ${RETCODE} -ne 0 ; then exit ${RETCODE} ; fi
    fi
done
#END FILE makepdfs.shy

echo "FINISHED RUNNING PDFLATEX ON *.TEX"

rm index.idx
cat *.idx > index.idx
makeindex index.idx
pdflatex index.tex

pdflatex contents.tex 
pdflatex start.tex 
pdflatex help.tex
rm -f x.pdf
rm -f xref.pdf
chmod u+r *
chmod u+w *
#cp start.pdf hyperbook/ 
cp start.pdf ..
#cp -p *.pdf hyperbook/hyper-tla
#rm -f hyperbook/hyper-tla/start.pdf
#rm -f hyperbook/hyper-tla/pdftex-s.pdf
#rm -f hyperbook/hyper-tla/hyperref.pdf
#cd hyperbook
#rm -f hyperbook.zip
#zip.exe hyperbook.zip start.pdf hyper-tla/* # hyper-tla/html/* 
#echo "CHECKING TEX FILES"
#cd ..
#sh checktexfilesused.sh
echo "DONE"
