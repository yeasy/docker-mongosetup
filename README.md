Mongo Setup
===
Docker images for setup a mongo cluster.


# Supported tags and respective Dockerfile links

* [`latest` (latest/Dockerfile)](https://github.com/yeasy/docker-mongosetup/blob/master/Dockerfile)

For more information about this image and its history, please see the relevant manifest file in the [`yeasy/docker-mongosetup` GitHub repo](https://github.com/yeasy/docker-mongosetup).

# What is docker-mongosetup?
Docker image with mongo installed and will run some configuration scripts. The image is built based on [Mongo 3.0](https://hub.docker.com/_/mongo/).

# How to use this image?
The docker image is auto built at [https://registry.hub.docker.com/u/yeasy/mongosetup/](https://registry.hub.docker.com/u/yeasy/mongosetup/).


## In Dockerfile
```sh
FROM yeasy/mongosetup:latest
```

## Local Run
When startup, it will run the `/scripts/mongosetup.sh` to config the mongo container as a single-node cluster. Also, you can replace this with your content.

```sh
$ docker run -d --link=mongo:mongo yeasy/mongosetup
```


# Which image is based on?
The image is based on official `mongo:3.0`.

# What has been changed?

## Config TZ
Config timezone to Asia/Shanghai.

## Add customized startup command
Add a script to setup other mongo nodes.

This image is officially supported on Docker version 1.7.1.

Support for older versions (down to 1.0) is provided on a best-effort basis.

# User Feedback
## Documentation
Be sure to familiarize yourself with the [repository's `README.md`](https://github.com/yeasy/docker-mongosetup/blob/master/README.md) file before attempting a pull request.

## Issues
If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/yeasy/docker-mongosetup/issues).

You can also reach many of the official image maintainers via the email.

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/yeasy/docker-mongosetup/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
