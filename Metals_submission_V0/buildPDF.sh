#!/bin/bash

filename=Flood_Appliation_of_Tuning_to_material_properties


if [[ "$(docker images -q latex)" == "" ]]; then
	echo "Building the latex image"
	docker build -t latex .
fi

docker run \
		--user=$(id -u) \
		--volume="/etc/group:/etc/group:ro" \
		--volume="/etc/passwd:/etc/passwd:ro" \
		--volume="/etc/shadow:/etc/shadow:ro" \
		--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
		-v "$(pwd)":/data \
		latex \
		pdflatex $filename.tex

docker run \
		--user=$(id -u) \
		--volume="/etc/group:/etc/group:ro" \
		--volume="/etc/passwd:/etc/passwd:ro" \
		--volume="/etc/shadow:/etc/shadow:ro" \
		--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
		-v "$(pwd)":/data \
		latex \
		bibtex $filename


docker run \
		--user=$(id -u) \
		--volume="/etc/group:/etc/group:ro" \
		--volume="/etc/passwd:/etc/passwd:ro" \
		--volume="/etc/shadow:/etc/shadow:ro" \
		--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
		-v "$(pwd)":/data \
		latex \
		pdflatex $filename.tex


docker run \
		--user=$(id -u) \
		--volume="/etc/group:/etc/group:ro" \
		--volume="/etc/passwd:/etc/passwd:ro" \
		--volume="/etc/shadow:/etc/shadow:ro" \
		--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
		-v "$(pwd)":/data \
		latex \
		pdflatex $filename.tex


rm -f $filename.aux
rm -f $filename.bbl
rm -f $filename.blg
rm -f $filename.log
rm -f $filename.out
