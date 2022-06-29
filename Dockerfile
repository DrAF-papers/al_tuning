FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y tzdata
RUN apt-get install -y  --no-install-recommends texlive-full
	#> /dev/null #for quiet execution
	
VOLUME /data
WORKDIR /data
