#!/bin/bash
set -e

RESULTS_FOLDER="results"
#Work in temporal directory
if [ -a $RESULTS_FOLDER ]; then
		echo "cannot create directory named \""$RESULTS_FOLDER"\": file already exists"
		exit 1
fi

mkdir $RESULTS_FOLDER
cd $RESULTS_FOLDER

#Load image for this project

wget -O - get.pharo.org/20+vm | bash
./pharo Pharo.image save PharoBootstrap --delete-old



#Load stable version of the monticello configuration, according to this git sources
REPO=http://smalltalkhub.com/mc/Guille/Seed/main
./pharo PharoBootstrap.image config $REPO ConfigurationOfHazelnut --install=bleedingEdge

echo "Configuration Loaded. running tests"

./pharo PharoBootstrap.image test --junit-xml-output "Seed.*"

echo "Script created and loaded. Finished! :D"