# Name of image either on local machine or on DockerHub which will be built on top of
FROM node

# Tells Docker to run all subsequent commands inside this directory
WORKDIR /app

# Which files should be included in the image
# The first argument tells it to include all folders and subfolders in the current directory
# The second argument tells it where it should get saved inside the docker image (since WORKDIR was set to /app, '.' will point to /app)
COPY package.json /app

# Execute commands when the image is created
RUN npm install

# By copying the source code after copying package.json and running `npm install`, Docker can skip redoing those steps for changes strictly to the source code
COPY . /app

# Meant to document which port will be available to the local system
# `docker run` command will still require adding `-p 3000:80`
EXPOSE 80

# Unlike RUN, this will not be executed when the image is created, but when the container is created from the image
# `node server.js` is entered as an array: `["node", "server.js"]`
CMD ["node", "server.js"]


# docker build -t goals:latest .
# docker run -p 3000:80 -d --rm --name goals-app goals:latest