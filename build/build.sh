#!/bin/bash
set -e

#Setup arguments
RESULTS_FOLDER="results"
if [ $# == 0 ]; then
	VERSION=bleedingEdge
else
	VERSION=$1
fi


#Work in temporal directory
if [ -a $RESULTS_FOLDER ]; then
		echo "cannot create directory named \""$RESULTS_FOLDER"\": file already exists"
		exit 1
fi

mkdir $RESULTS_FOLDER
cd $RESULTS_FOLDER

#Load image for this project

wget -O - guillep.github.io/files/get/OzVmLatest | bash
wget -O - get.pharo.org/20 | bash
./oz Pharo.image save PharoBootstrap --delete-old



#Load stable version of the monticello configuration, according to this git sources
REPO=http://smalltalkhub.com/mc/Guille/Seed/main
./oz PharoBootstrap.image config $REPO ConfigurationOfHazelnut --install=$VERSION

echo "Configuration Loaded. Opening script..."

echo -e "
Workspace openContents: '\"I am a builder for a Pharo Candle system. I bootstrap the system using an object space. You configure myself by providing mi a kernelSpec, and sending me the message #buildKernel.\"

skipped := #(''FloatArrayTest.hz'' ''MatrixTest.hz'' ''ArrayTest.hz'' ''AppRegistry class.hz'' ''MIMEDocument.hz'' ''Color.hz'' ''CodeImporter.hz'').
\"Load a seed from the folder of the downloaded sources\"
seed := PharoSeed new
	fromDirectoryNamed: ''../source'';
	except: [ :a | skipped includes: a basename ];
	buildSeed.

\"Create an object space that will use an AST evaluator to run some code\"
objectSpace := AtObjectSpace new.
objectSpace worldConfiguration: OzPharo20 world.
objectSpace interpreter: (AtASTEvaluator new codeProvider: seed; yourself).

\"Create a builder, and tell it to bootstrap. Voilá, the objectSpace will be full\"
builder := Pharo30Builder new.
builder kernelSpec: seed.
builder objectSpace: objectSpace.
builder	buildKernel.

objectSpace serializeInFileNamed: ''PharoKernel.image''.'.
Smalltalk snapshot: true andQuit: true.
" > ./script.st

./oz PharoBootstrap.image script.st
rm script.st
rm PharoDebug.log
echo "Script created and loaded. Finished! :D"
