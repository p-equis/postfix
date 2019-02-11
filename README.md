# Development

1. Install docker
2. `./drake` (think of this as `docker-rake` - running rake inside a docker container)

# Running arbitrary rake tasks

The `./drake` script takes whatever command you give it and runs that with rake.

Examples:
+ `./drake --tasks # lists all rake tasks`
+ `./drake spec # run specs`
