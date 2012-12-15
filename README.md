haml-sass_email-boilerplate
===========================

###Features

* Support for partials. Use in your haml file like so: ```%tr= partial("filename")```
* All instance variables are available in sass too: ```background: variable(blue)```. So you can DRY up things like ```bgcolor```.

### How to use

* set the variables you want to share between haml and sass in ```settings.rb```
* compile via ```./compile.rb```. This generates the html, css as well as a zip-file containing the css and images.
* bring styles inline

### Use with Campaignmonitor

Upload ```index.html``` and ```assets.zip``` via the "import template" dialog and you should be set. Campaignmonitor will inline all the styles and host all refenrenced images. 
