#!/bin/bash

dest=$1

mkdir $dest
##cp sections/* $dest
cp images/* $dest

cp Flood_Appliation_of_Tuning_to_material_properties.tex $dest/Manuscript.tex
cp sn-jnl.cls $dest
cp sn-basic.bst $dest
cp references.bib $dest

cd $dest 

# rm part_residuals_Melt_pool_length.pdf 
# rm part_residuals_Melt_pool_volume.pdf 
# rm part_residuals_Melt_pool_width.pdf 
# rm slice_annotated.svg

sed -i '/graphicspath/d' Manuscript.tex


sections=(
	acronyms
	abstract
	introAMsim
	model_description
	model_description
	sensetivity_results
	sim_setup
	sim_analysis
	results
	validation
	conclusions
	)



# for sec in "${sections[@]}"
# do
# 	line=$(grep -irn "\input{sections\/$sec}" Manuscript.tex | grep -Eo '^[^:]+')
# 	sed -i "$line d" Manuscript.tex

# 	IFS=''
# 	while read -r contents
# 	  do
# 	  	contents=$(echo $contents | sed -e 's/\\/\\\\/g')
# 		sed -i "$line i \\$contents" Manuscript.tex 
# 		line=$((line+1))
# 	  done < "../sections/$sec.tex"
# done 



