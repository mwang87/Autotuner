test-push:
	act -P ubuntu-latest=nektos/act-environments-ubuntu:18.04


## Docker Sections
build:
	docker build -t autotuner . 

bash:
	docker run -it autotuner /bin/bash

build-r:
	docker build -t autotuner-r -f R.Dockerfile . 

bash-r:
	docker run -it autotuner-r /bin/bash

testing-r:
	docker build -t autotuner-r -f R.Dockerfile . 
	docker run -it autotuner-r /app/testing/run_testing.sh

build-r-worker:
	docker build -t autotuner-r-worker -f R.Dockerfile . 

build-r-studio:
	docker build -t autotuner-r-studio -f R-studio.Dockerfile . 

run-r-studio:
	docker run --rm -p 8787:8787 -e PASSWORD=ming autotuner-r-studio

run-r-studio-test:
	docker run --rm -p 8787:8787 -e USER=ming -e PASSWORD=yourpasswordhere rocker/rstudio

