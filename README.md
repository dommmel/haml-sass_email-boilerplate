haml-sass_email-boilerplate
===========================

### Features

* Support for simple partials. Use in your haml file like so: ```partial("filename"), :localvar=>"nice one", :another_localvar=>"I like that one too"```.
* Settings: You can use all variables set in ```settings.rb``` not only in your haml templates but in your sass files as well like so:  ```background: variable(varname)```. That way you can DRY up things like ```bgcolor```.

### How to use

* Edit the files within the ```src``` folder. Set variables you want to share between haml and sass in ```settings.rb```
* compile via ```rake``` or watch via ```guard```. This generates the html and css and copies over image files. All project files can then be found in the ```target```folder
* Use some tool to bring CSS styles inline

### Watch for changes 

run ```guard``` from the command line to automatically compile and build whenever you add or change a file.
