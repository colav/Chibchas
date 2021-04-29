<center><img src="https://raw.githubusercontent.com/colav/colav.github.io/master/img/Logo.png"/></center>

# Chibchas
InstituLAC Automation Tools

# Description
Package allows to download data from intitulac and upload it to googdrive to do validation

# Installation

## Configure Google Drive Api
Create a project https://developers.google.com/workspace/guides/create-project
create a oauth credentials https://developers.google.com/drive/api/v3/enable-drive-api

download the json file with configuration
![JSON Api Config](img/apijson.png?raw=true "Download json with credentials")


## RClone
required administrative permissions with apt.

`apt install rclone`


configure rclone following [this instructions](https://rclone.org/drive/) 

client_id and client_secret can be found on the json previously downloaded.

Mount the filesystem, it doesn't required administrative permissions.

`
 rclone mount -v  --daemon remote:project/path  local/path
`



## Package
`pip install chibchas`

# Usage
Let's start the server executing
```.sh
chibchas_server
```
Or using some command line options
```.sh
chibchas_server --port 8080 --ip x.x.x.x
```

where x.x.x.x is your local ip

you can access to the server for the endpoints for example on: http://127.0.1.1:9999

if depends of the ip and port that you are providen to chibchas.


# License
BSD-3-Clause License 

# Links
http://colav.udea.edu.co/




