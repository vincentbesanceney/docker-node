# docker-node

Dockerfile for [Node.js](https://nodejs.org/)

## Usage

```
docker run -ti vincentbesanceney/node:8.6.0 node
```

## Build Notes

The Docker image can be tailored through variables during the build process.
Note that `NODE_VERSION` is required in order to specify which Node version to
build.

| Build-time Variable | Description |
| ------------------- | ----------- |
| `NODE_VERSION`      | **Mandatory**. Node.js version to build. |
| `NODE_USER`         | *Optional*. Node user. |
| `NODE_UID`          | *Optional*. Node user ID. |
| `NODE_GROUP`        | *Optional*. Node group. |
| `NODE_GID`          | *Optional*. Node group ID. |
| `NODE_HOME`         | *Optional*. Home directory for Node user. |

To build `vincentbesanceney/node:8.6.0` Docker image, run:

```
make build NODE_VERSION=8.6.0
```
