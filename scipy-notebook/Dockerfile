# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM wodeai/minimal-notebook

MAINTAINER Jupyter Project <jupyter@googlegroups.com>

USER root

# libav-tools for matplotlib anim
RUN apt-get update && \
    apt-get install -y --no-install-recommends libav-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

# Install Python 3 packages
# Remove pyqt and qt pulled in for matplotlib since we're only ever going to
# use notebook-friendly backends in these images
RUN conda install --quiet --yes \
    'mkl-service' \
    'ipywidgets=7.0*' \
    'pandas=0.19*' \
    'numexpr=2.6*' \
    'matplotlib=2.0*' \
    'scipy=0.19*' \
    'seaborn=0.7*' \
    'scikit-learn=0.18*' \
    'scikit-image=0.12*' \
    'sympy=1.0*' \
    'cython=0.25*' \
    'patsy=0.4*' \
    'statsmodels=0.8*' \
    'cloudpickle=0.2*' \
    'dill=0.2*' \
    'numba=0.31*' \
    'bokeh=0.12*' \
    'sqlalchemy=1.1*' \
    'hdf5=1.8.17' \
    'h5py=2.6*' \
    'vincent=0.4.*' \
    'beautifulsoup4=4.5.*' \
    'protobuf=3.*' \
    'xlrd'  && \
    conda remove --quiet --yes --force qt pyqt && \
    conda clean -tipsy && \
    # Activate ipywidgets extension in the environment that runs the notebook server
    jupyter nbextension enable --py widgetsnbextension --sys-prefix && \
    fix-permissions $CONDA_DIR

# Install facets which does not have a pip or conda package at the moment
RUN cd /tmp && \
    git clone https://github.com/PAIR-code/facets.git && \
    cd facets && \
    jupyter nbextension install facets-dist/ --sys-prefix && \
    rm -rf facets && \
    fix-permissions $CONDA_DIR

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions /home/$NB_USER

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
