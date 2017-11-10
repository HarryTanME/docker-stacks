#!/bin/bash
#this script builds the full stack of jupyter builders.
#the purpose of building Wode.AI version is to use the username wode-user, 
#rather than using the built-in jovyan user, which may confuse Wode.AI users. 
docker image rm  wodeai/base-notebook
docker image rm  wodeai/minimal-notebook
docker image rm  wodeai/scipy-notebook
docker image rm  wodeai/r-notebook
docker image rm  wodeai/tensorflow-notebook
docker image rm  wodeai/datascience-notebook
#docker image rm  wodeai/pyspark-notebook
#docker image rm  wodeai/all-spark-notebook

docker image rm   903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:base-notebook
docker image rm   903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:minimal-notebook
docker image rm   903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:scipy-notebook
docker image rm   903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:r-notebook
docker image rm   903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:tensorflow-notebook
docker image rm   903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:datascience-notebook
#docker image rm   903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:pyspark-notebook
#docker image rm   903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:all-spark-notebook

cd base-notebook
docker build -t wodeai/base-notebook .
cd ../minimal-notebook
docker build -t wodeai/minimal-notebook .
cd ../scipy-notebook
docker build -t wodeai/scipy-notebook .
cd ../nlp-notebook
docker build -t wodeai/nlp .
cd ../tensorflow-notebook
docker build -t wodeai/deeplearning .
cd ../datascience-notebook
docker build -t wodeai/datascience .
#cd ../pyspark-notebook
#docker build -t wodeai/pyspark-notebook .
#cd ../all-spark-notebook
#docker build -t wodeai/all-spark-notebook .
cd ../dl-gpu
docker build -t wodeai/deeplearning-gpu .
cd ..




#Push the dockers to AWS ECR 
docker tag wodeai/base-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:base-notebook
docker tag wodeai/minimal-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:minimal-notebook
docker tag wodeai/scipy-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:scipy-notebook
docker tag wodeai/nlp 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:nlp
docker tag wodeai/deeplearning 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:deeplearning
docker tag wodeai/datascience 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:datascience
#docker tag wodeai/pyspark-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:pyspark-notebook
#docker tag wodeai/all-spark-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:all-spark-notebook
docker tag wodeai/deeplearning-gpu 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:deeplearning-gpu

docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:base-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:minimal-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:scipy-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:nlp
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:deeplearning
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:datascience
#docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:pyspark-notebook
#docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:all-spark-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:deeplearning-gpu

