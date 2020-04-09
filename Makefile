test-push:
	act -P ubuntu-latest=nektos/act-environments-ubuntu:18.04-full -b -r


## Docker Sections
build:
	docker build -t autotuner . 

bash:
	docker run -it autotuner /bin/bash

build-r:
	docker build -t autotuner-r -f R.Dockerfile . 

bash-r:
	docker run -it autotuner-r /bin/bash