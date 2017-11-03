# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM wodeai/scipy-notebook

MAINTAINER Jupyter Project <jupyter@googlegroups.com>

# Install Tensorflow
RUN conda install --yes \
    'tensorflow=1.3*' \
    'theano=0.9*' \
    'pytorch' \
    'torchvision' \
    'keras=2.0*' \
    '-c soumith' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR

RUN pip install --no-cache-dir   \
    'graphviz' \
    'mxnet-mkl==0.11.0'   \
    'prettytensor' 
    

RUN source activate py27 && \
    pip install --no-cache-dir   \
    'tensorflow==1.3.0' \
    'theano==0.9.0' \
    'keras==2.0.6 '  \
    'graphviz' \
    'mxnet-mkl==0.11.0'   \
    'prettytensor' && \
    source deactivate  
    

#RUN source activate py27 && \
#    pip install http://download.pytorch.org/whl/cu75/torch-0.2.0.post3-cp27-cp27mu-manylinux1_x86_64.whl  && \
#    pip install torchvision  && \
#    source deactivate    
    
USER root
WORKDIR /root/
RUN apt-get update & apt-get install -y cmake

RUN git clone --recursive https://github.com/caffe2/caffe2.git && cd caffe2 && \
    make && cd build && sudo make install 
    
USER $NB_USER
