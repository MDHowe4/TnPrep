FROM continuumio/miniconda3:22.11.1-alpine

LABEL image.author.name "Michael Howe"
LABEL image.author.email "howex118@umn.edu"

COPY environment.yml .
RUN \
    conda env update -n root -f environment.yml \
    && conda clean -a
