#!/bin/bash

filename=Flood_Appliation_of_Tuning_to_material_properties
# clean_filename=${filename}_clean
# sed 's/% final/final/g' ${filename}.tex > ${clean_filename}.tex

if [[ "$(docker images -q latex)" == "" ]]; then
	echo "Building the latex image"
	docker build -t latex .
fi

for file in $filename #$clean_filename
do 
	echo "Processing file: " $file

	docker run \
			--user=$(id -u) \
			--volume="/etc/group:/etc/group:ro" \
			--volume="/etc/passwd:/etc/passwd:ro" \
			--volume="/etc/shadow:/etc/shadow:ro" \
			--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
			-v "$(pwd)":/data \
			latex \
			pdflatex $file.tex

	docker run \
			--user=$(id -u) \
			--volume="/etc/group:/etc/group:ro" \
			--volume="/etc/passwd:/etc/passwd:ro" \
			--volume="/etc/shadow:/etc/shadow:ro" \
			--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
			-v "$(pwd)":/data \
			latex \
			bibtex $file


	docker run \
			--user=$(id -u) \
			--volume="/etc/group:/etc/group:ro" \
			--volume="/etc/passwd:/etc/passwd:ro" \
			--volume="/etc/shadow:/etc/shadow:ro" \
			--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
			-v "$(pwd)":/data \
			latex \
			pdflatex $file.tex


	docker run \
			--user=$(id -u) \
			--volume="/etc/group:/etc/group:ro" \
			--volume="/etc/passwd:/etc/passwd:ro" \
			--volume="/etc/shadow:/etc/shadow:ro" \
			--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
			-v "$(pwd)":/data \
			latex \
			pdflatex $file.tex


	rm -f $file.aux
	rm -f $file.bbl
	rm -f $file.blg
	rm -f $file.log
	rm -f $file.out
done