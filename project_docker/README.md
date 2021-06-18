# Docker project

***

## Task

***

* Package your Python application into a docker container of minimal size
* Write a README.md explaining how to create and run the container

## Requirements
* the result of the build must be an image not exceeding 100Mb
* the app needs to listen on port 8080
* query `curl -d '{"animal": "cow", "sound": "moooo", "count": 3}' http://localhost:8080/ `should return the expected response
* the directory with the job must contain only the files needed for the build and README.md
* only `docker build` and/or `docker-compose` may be used

## Hints

* [Julia Evans blog](https://jvns.ca/)
* [Julia Evans wizardzines](https://wizardzines.com/)
* [Jessie Frazelle blog/links to talks](https://blog.jessfraz.com/post/talks/#2018)
* [Jessie Frazelle dockerfiles repo](https://github.com/jessfraz/dockerfiles)
* [random guys, bocker project](https://github.com/p8952/bocker)
