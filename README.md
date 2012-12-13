haml-sass_email-boilerplate
===========================

Features

* Support for partials. Use in your haml file like so: ```%tr= partial("filename")```
* All instance variables are available in sass too: ```background: variable(blue)```. So you can DRY up things like ```bgcolor```.

How to use
* set the variables you want to share between haml and sass in ```settings.rb```
* compile via ```./compile.rb```
* after development - bring styles inline