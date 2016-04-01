docker-tinymeteor
=================

##Needs updating

A tiny docker image (~14mb) that can be used to run meteor apps. Inspired by [docker-tinynode](https://github.com/jprjr/docker-tinynode)

This image has NodeJS 0.10.43

1. Clone this repo
2. Run `./tinymeteor_build.sh`
3. Get coffee... lots of coffee... and maybe a sandwich or a movie
4. `cd Docker`
5. `docker build -t tinymeteor .`
6. enjoy

***Note:***
The 'npm install' step for Meteor 1.3 apps requires gcc for Fibers. Buildroot does not support installing
gcc into the target machine. Therefore, the npm installation must be done outside of the resulting docker
container.  In order for the installed packages to be compatible with this container, volume mount the
built application into a `node:0.10.43` docker container and execute npm before copying the application
into this buildroot image.

Since npm installing has to be performed outside the resulting image, npm has been excluded from this
image to reduce size
