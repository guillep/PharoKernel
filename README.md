PharoKernel
===========

This is the source code of the Pharo Kernel. A Pharo image can be generated from the Bootstrap project called Hazelnut.

To download Hazelnut in a Pharo Image the following code should be executed:

Gofer it
	smalltalkhubUser: 'Guille' project: 'Seed';
	package: 'ConfigurationOfHazelnut';
	load.
(ConfigurationOfHazelnut project version: #stable) load
