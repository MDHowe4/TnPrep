FROM continuumio/miniconda3:4.10.3

LABEL image.author.name "Michael Howe"
LABEL image.author.email "howex118@umn.edu"

COPY environment.yml .
RUN \
    conda env update -n root -f conda.yml \
    && conda clean -a

RUN apt-get install -y procps