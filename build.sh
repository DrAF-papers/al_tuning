#!/bin/bash

if [[ "$(docker images -q latex)" == "" ]]; then
	echo "Go get a coffee, I'm need to build your latex image"
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
		/bin/bash ./reportWorker.sh $1 $2 $3 $4 $5 $6
		
		# /bin/bash ./buildDissertation.sh 
