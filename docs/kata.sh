#!/bin/bash

# The kata script

#############################################
# 1 - Create a new repo                     #
#############################################

# 1.1 - Create the directory on your local file system
mkdir js-bowling-kata && cd $_

# 1.2 - Add a .gitignore file to exclude uneeded files
wget -O .gitignore https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore
echo "
.vscode/
package-lock.json" >> .gitignore

# 1.3 - Use the latest long term support version of node
nvm install lts/*
echo `nvm version lts/*` >| .nvmrc
nvm use

# 1.4 - Create a package.json file
echo '{
  "scripts": {
    "test": "NODE_ENV=test jest"
  }
}' >| package.json

# 1.5 - Add the jest testing framework
npm install --save-dev jest

# 1.6 - Add a test script to the package.json file
sed -i 's/"test": "echo \"Error: no test specified\" && exit 1"/"test": "jest"/' package.json
