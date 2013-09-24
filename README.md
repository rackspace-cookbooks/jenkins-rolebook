jenkins-rolebook
================

This is a sample rolebook to install jenkins and rbenv.

This also installs a number of jenkins plugins and ruby-1.9.3-p448.

Recipes
=======

##default.rb
Includes the necessary supporting recipes

##master.rb
Sets jenkins specific attributes and plugins

##test-kitchen.rb
Currently it just installs rbenv and a specific version of ruby.
In the future it should install necessary gems to get test-kitchen running.