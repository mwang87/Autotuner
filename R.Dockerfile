FROM r-base:3.6.3
MAINTAINER Mingxun Wang "mwang87@gmail.com"

#Random System Utilities
RUN apt-get update
RUN apt-get install -y procps
RUN apt-get install -y build-essential

RUN Rscript -e 'install.packages("DT", repos="http://cran.us.r-project.org")'
RUN apt-get install -y libssl-dev
RUN apt-get install -y libxml2-dev
RUN Rscript -e 'options(Ncpus = 16);install.packages("commonmark", repos="http://cran.us.r-project.org")'
RUN apt-get install -y libcurl4-openssl-dev
RUN Rscript -e 'options(Ncpus = 16);install.packages("httr", repos="http://cran.us.r-project.org")'
RUN Rscript -e 'options(Ncpus = 16);install.packages("devtools", repos="http://cran.us.r-project.org")'
RUN apt-get install -y netcdf-bin
RUN apt-get install -y r-cran-ncdf4
RUN Rscript -e 'options(Ncpus = 16);library(devtools);install_github("crmclean/autotuner")'


COPY . /app
WORKDIR /app