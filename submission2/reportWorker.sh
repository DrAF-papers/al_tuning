#!/bin/bash
clean=1
build=1

#parsing cli parameters
while test $# -gt 0
do
    case "$1" in
        -noClean) 
		echo "Not cleaning after build"
                clean=0
            ;;
		-build) 
		echo "Not cleaning after build"
                build=1
            ;;
		-cd) cd $2
    esac
    shift
done

file="reportWorker_files.sh"
sed 's/^#.*$//' $file > temp_$file
sed -i '/^$/d' temp_$file
readarray -t reports < temp_$file
rm temp_$file


function build() {
	pdflatex $1.tex > /dev/null
	# biber --output_resolve $1 > /dev/null
	bibtex $1 > /dev/null
	pdflatex $1.tex > /dev/null
	pdflatex $1.tex > $1.output
	
	grep "arning" $1.output > $1.warns
	grep -B 4 -A 4 "! Emergency stop." $1.output > $1.errors
	}

function ghostscript() {
	mv $1.pdf orig.pdf
	# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r500 -sOutputFile=$1.pdf orig.pdf
	# gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r200 -sOutputFile=$1.pdf orig.pdf
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r500 -sOutputFile=$1.pdf orig.pdf
	rm orig.pdf
	}

function cleanup() {
	# #cleanup temporary files
	rm -f $1.log
	rm -f $1.aux
	rm -f $1.blg
	rm -f $1.bbl
	rm -f $1.nav
	rm -f $1.out
	rm -f $1.snm
	rm -f $1.toc
	rm -f $1.dvi
	rm -f $1.spl
	rm -f $1.lot
	rm -f $1.lof
	rm -f $1.bcf
	rm -f $1-blx.bib
	rm -f $1.run.xml
	rm -f $1.todo
	rm -f $1.acn
	rm -f $1.acr
	rm -f $1.alg
	rm -f $1.glg
	rm -f $1.glo
	rm -f $1.gls
	rm -f $1.ist
	rm -f $1.slg
	rm -f $1.sls
	rm -f $1.slo
	rm -f $1.tlf
	rm -f $1.tle
	rm -f $1.tld
	rm -f $1.ntn
	rm -f $1.tdo
	# rm -f $1.output
	
	# if .errors is empty then delete it.
	if [ ! -s $1.errors ] ; then
	  rm $1.errors
	fi
	# if .warns is empty then delete it.
	if [ ! -s $1.warns ] ; then
	  rm $1.warns
	fi
	}


if [ $build == 1 ]; then 
	for file in "${reports[@]}"
	do
		echo "Building file" $file
		build $file
		ghostscript $file
	done

	if [ $clean == 1 ]; then
		for file in "${reports[@]}"
		do
			localfile=$(basename "$file")
			cleanup $localfile
			cleanup $file
		done
	fi
fi
