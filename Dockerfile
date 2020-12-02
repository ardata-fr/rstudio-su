ARG ROOT_CONTAINER=davidgohel/minimal-nb:r-4.0.3
ARG BASE_CONTAINER=$ROOT_CONTAINER
FROM $BASE_CONTAINER

LABEL maintainer="ArData <david.gohel@ardata.fr>"

USER root

ENV RSTUDIO_VERSION 1.2.5001

RUN wget --quiet https://download2.rstudio.org/server/bionic/amd64/rstudio-server-${RSTUDIO_VERSION}-amd64.deb
RUN gdebi -n rstudio-server-${RSTUDIO_VERSION}-amd64.deb

RUN echo "rsession-which-r=/opt/conda/lib/R" >> /etc/rstudio/rserver.conf

USER $NB_UID

RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com'), download.file.method = 'libcurl');" >> /opt/conda/lib/R/etc/Rprofile.site

RUN pip install --no-cache-dir jupyter-rsession-proxy

ENV LD_LIBRARY_PATH="/lib:/usr/lib/x86_64-linux-gnu:/opt/conda/lib/R/lib"
ENV PATH=$PATH:/usr/lib/rstudio-server/bin

USER root

ADD package.R .
RUN R -e 'source("package.R")'

# R packages
RUN conda install --quiet --yes \
    'r-bh' \
    'r-stringi' \
    'r-rcpp' \
    'r-testthat' \
    'r-tidyverse' \
    'r-broom' \
    'r-caret' \
    'r-curl' \
    'r-data.table' \
    'r-dbi' \
    'r-dbplyr' \
    'r-lubridate' \
    'r-stringr' \
    'r-rvg' \
    'r-flextable' \
    'r-sf' \
    'r-openssl' \
    'r-shiny' \
    'r-magick' \
    'r-shinywidgets' \
    'r-skimr' \
    'r-roxygen2' \
    'r-xlsx' \
    'r-openxlsx' \
    && conda clean --all -f -y



USER $NB_UID
