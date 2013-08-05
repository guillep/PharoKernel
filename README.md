Pharo Kernel
===========

```
	WARNING: This project contains the current development branch of the Pharo Kernel bootstrap.
	For a stable version, check other branches.
```

Pharo Kernel is a selection of packages to create a minimal [Pharo](http://www.pharo.org) distribution, based on the selection made from Pavel Krivanek. The main purpose of this distribution is to be the seed of future Pharo images.

The main purpose of this project in particular is the Bootstrap of a Pharo Kernel image using the sourcecode under the _source_ folder. In order to bootstrap, we need to install the bootstrap library into a Pharo environment. Look at _installation_ and _usage_ for more details.

Installation
------------

In order to download the complete environment to bootsrap the Pharo Kernel, there is only need for execute the following bash script on the master folder.
```bash
build/build.sh
```

Once downloaded and built, a _results_ folder will be created. The results folder will contain a complete Pharo environment, with the following files:
- pharo_vm: a folder containing the Pharo Virtual Machine
- pharo and pharo_ui scripts to run the VM
- PharoBootstrap.image: Pharo 2.0 image file with the pharo candle project installed
- PharoBootstrap.changes: the changes log of the correspondent image with the same name
- package-cache: a folder for caching Pharo's monticello packages  

Usage
-----

To create a Pharo Kernel image from source code, we bootstrap it following the process described in [here](http://playingwithobjects.wordpress.com/2013/05/06/bootstrap-revival-the-basics/). To run the bootstrap you need to open the PharoBootstrap.image with the VM supporting ui. That can be done in the command line with the following script:

```bash
cd results
pharo-ui PharoBootstrap.image
```

The Pharo image will contain the Pharo 2.0 welcome workspace, and a workspace with the code to run the PharoBootstrap.

```
WARNING: This code is still not up to date.
```

Load the sourcecode into the image:
```smalltalk
seed := PharoCandleSeed new
    fromDirectoryNamed: '../source';
    buildSeed.
```

Create an object space that will use an AST evaluator to run code during the bootstrap. An objectspace is an object enclosing the bootstrapped image.
```smalltalk
objectSpace := AtObjectSpace new.
objectSpace interpreter: (AtASTEvaluator new codeProvider: seed; yourself).
```

Create a PharoCandle builder, and tell it to bootstrap. Voilá, the objectSpace will be full
```smalltalk
builder := PharoCandleBuilder new.
builder objectSpace: objectSpace.
builder kernelSpec: seed.
builder	buildKernel.
```


Browse the bootstrapped objectSpace by evaluating
```smalltalk
objectSpace browse.
```

You can serialize the objectSpace into an image file (Cog format) by evaluating
```smalltalk
objectSpace serializeInFileNamed: 'PharoSeed.image'.
```

Pharo Kernel Overview
----------------------

TODO

TODOs
----------------------
- Autogenerate this script :)