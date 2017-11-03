FROM wodeai/scipy-notebook


USER root

RUN apt-get update && \
    apt-get install -y default-jre 
    #echo " JAVA_HOME=\"/usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java" ">> /etc/environment && \
    #source /etc/environment

USER $NB_USER
WORKDIR /home/$NB_USER/

RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2017-06-09.zip && \
    unzip stanford-corenlp-full-2017-06-09.zip && \
    rm ./stanford-corenlp-full-2017-06-09.zip && \
    mv stanford-corenlp-full-2017-06-09/ stanford-corenlp/ && \
    cd stanford-corenlp/ && \
    for file in `find . -name "*.jar"`; do export CLASSPATH="$CLASSPATH:`realpath $file`"; done && \
    for file in `find /root/stanford-corenlp-full-2017-06-09/ -name "*.jar"`; do export CLASSPATH="$CLASSPATH:`realpath $file`"; done 
RUN pip install -U nltk textblob gensim spacy pycorenlp pyLDAvis watermark wordcloud
    #python -m nltk.downloader -d /home/wode-user/nltk_data all
    #python -m textblob.download_corpora
    #python -m spacy download en
RUN source activate py27 && \
    pip install -U nltk textblob gensim spacy pycorenlp pyLDAvis watermark wordcloud && \
    source deactivate
    
ENV NLTK_DATA="/home/$NB_USER/shared/data/common_data/nltk_data"
    
