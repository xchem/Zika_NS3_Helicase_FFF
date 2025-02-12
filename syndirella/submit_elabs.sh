#!/bin/bash

set -e

DIR=$1

if [[ -z $DIR ]] ; then
	echo "no merging hypothesis nickname provided"
	exit 1
fi

cp -v run_elaboration.sh $DIR/

cd $DIR

for FILE in *"_syndirella_input.csv"; do
	KEY=${FILE:0:-21}
	echo $KEY

	sb.sh --job-name "$DIR"_syndirella_"$KEY" --ntasks=1 --cpus-per-task=1 --mem=3GB $DATA/maxwin/slurm/run_bash_with_conda.sh run_elaboration.sh $KEY

done
