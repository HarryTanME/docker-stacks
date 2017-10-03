# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM wodeai/scipy-notebook

MAINTAINER Jupyter Project <jupyter@googlegroups.com>

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*
    
# Install XGBoost library
RUN cd /tmp && \
    git clone --recursive https://github.com/dmlc/xgboost && \
    cd xgboost && \
    make -j4 && \
    cd python-package; python setup.py install
    
# Julia dependencies
# install Julia packages in /opt/julia instead of $HOME
ENV JULIA_PKGDIR=/opt/julia

RUN . /etc/os-release && \
    echo "deb http://ppa.launchpad.net/staticfloat/juliareleases/ubuntu $VERSION_CODENAME main" > /etc/apt/sources.list.d/julia.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3D3D3ACC && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    julia && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Show Julia where conda libraries are \
    echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /usr/etc/julia/juliarc.jl && \
    # Create JULIA_PKGDIR \
    mkdir $JULIA_PKGDIR && \
    chown $NB_USER $JULIA_PKGDIR && \
    fix-permissions $JULIA_PKGDIR

USER $NB_USER

# R packages including IRKernel which gets installed globally.
RUN conda config --system --add channels r && \
    conda install --quiet --yes \
    'rpy2=2.8*' \
    'r-base=3.3.2' \
    'r-irkernel=0.7*' \
    'r-plyr=1.8*' \
    'r-devtools=1.12*' \
    'r-tidyverse=1.0*' \
    'r-shiny=0.14*' \
    'r-rmarkdown=1.2*' \
    'r-forecast=7.3*' \
    'r-rsqlite=1.1*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=0.2*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-crayon=1.3*' \
    'r-randomforest=4.6*' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR

# Add Julia packages
# Install IJulia as jovyan and then move the kernelspec out
# to the system share location. Avoids problems with runtime UID change not
# taking effect properly on the .local folder in the jovyan home dir.
RUN julia -e 'Pkg.init()' && \
    julia -e 'Pkg.update()' && \
    julia -e 'Pkg.add("HDF5")' && \
    julia -e 'Pkg.add("Gadfly")' && \
    julia -e 'Pkg.add("RDatasets")' && \
    julia -e 'Pkg.add("IJulia")' && \
    # Precompile Julia packages \
    julia -e 'using HDF5' && \
    julia -e 'using Gadfly' && \
    julia -e 'using RDatasets' && \
    julia -e 'using IJulia' && \
    # move kernelspec out of home \
    mv $HOME/.local/share/jupyter/kernels/julia* $CONDA_DIR/share/jupyter/kernels/ && \
    chmod -R go+rx $CONDA_DIR/share/jupyter && \
    rm -rf $HOME/.local && \
    fix-permissions $JULIA_PKGDIR $CONDA_DIR/share/jupyter

RUN mkdir /home/$NB_USER/.jupyter/
  
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/jupyter_notebook_config.py
COPY custom.js /home/$NB_USER/.jupyter/custom/


USER root

RUN rm /bin/sh && ln -s /bin/bash /bin/sh 

RUN apt-get update && \
    apt-get install -y --no-install-recommends libncurses5-dev  \
    software-properties-common  \
    libjpeg8-dev && \
    ln -s /usr/lib/x86_64-linux-gnu/libjpeg.so /usr/lib && \
    apt-get install -y libjpeg8 libjpeg62-dev libfreetype6 libfreetype6-dev

USER $NB_USER

COPY requirements.txt /home/$NB_USER/
RUN conda create -y -n py27 python=2.7 && \
    source activate py27 && \
    conda install notebook ipykernel && \
    ipython kernel install --user && \
    conda install -y bcolz && \
    pip install -r ~/requirements.txt && \    
    source deactivate  && \
    source activate root  && \
    conda install notebook ipykernel && \
    ipython kernel install --user && \
    pip install -r ~/requirements.txt && \
    source deactivate  && \
    rm -f /home/$NB_USER/requirements.txt