FROM ubuntu:23.04
# FROM sagemathinc/cocalc

RUN apt-get update
RUN apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y --no-install-recommends texlive-full
	#> /dev/null #for quiet execution
	
# RUN apt-get install -y --no-install-recommends sagetex 
RUN apt-get install -y --no-install-recommends sagemath
# RUN sage -i sagetex
VOLUME /data
WORKDIR /data
