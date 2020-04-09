FROM continuumio/miniconda3
MAINTAINER Mingxun Wang "mwang87@gmail.com"

#Random System Utilities
RUN apt-get update
RUN apt-get install -y procps
RUN apt-get install -y build-essential

#Installing R Requirements
RUN conda config --prepend channels bioconda
RUN conda config --prepend channels conda-forge
RUN conda install r-base=3.6.1
RUN conda install r-data.table
RUN conda install r-ggplot2
RUN conda install bioconductor-msnbase

RUN apt-get install -y libssl-dev
#RUN conda install -c conda-forge r-devtools
#RUN conda install -c bioconda bioconductor-biocinstaller
RUN Rscript -e 'install.packages("DT", repos="http://cran.us.r-project.org")'
RUN apt-get install -y libgit2-dev
RUN conda install -c anaconda openssl
RUN conda install -c conda-forge libgit2
RUN conda install -c anaconda zlib
RUN Rscript -e 'options(Ncpus = 16);install.packages("commonmark", repos="http://cran.us.r-project.org")'

RUN Rscript -e 'options(Ncpus = 16);install.packages("devtools", repos="http://cran.us.r-project.org")'
RUN Rscript -e 'library(devtools);install_github("crmclean/autotuner")'

COPY . /app
WORKDIR /app