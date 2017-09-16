#!/bin/bash
#this script builds the full stack of jupyter builders.
#the purpose of building Wode.AI version is to use the username wode-user, 
#rather than using the built-in jovyan user, which may confuse Wode.AI users. 

cd base-notebook
docker build -t wodeai/base-notebook .
cd ../minimal-notebook
docker build -t wodeai/minimal-notebook .
cd ../scipy-notebook
docker build -t wodeai/scipy-notebook .
cd ../r-notebook
docker build -t wodeai/r-notebook .
cd ../tensorflow-notebook
docker build -t wodeai/tensorflow-notebook .
cd ../datascience-notebook
docker build -t wodeai/datascience-notebook .
cd ../pyspark-notebook
docker build -t wodeai/pyspark-notebook .
cd ../all-spark-notebook
docker build -t wodeai/all-spark-notebook .
cd ..




#Push the dockers to AWS ECR 
docker tag wodeai/base-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:base-notebook
docker tag wodeai/minimal-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:minimal-notebook
docker tag wodeai/scipy-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:scipy-notebook
docker tag wodeai/r-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:r-notebook
docker tag wodeai/tensorflow-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:tensorflow-notebook
docker tag wodeai/datascience-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:datascience-notebook
docker tag wodeai/pyspark-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:pyspark-notebook
docker tag wodeai/all-spar-notebook 903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:all-spar-notebook

docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:base-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:minimal-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:scipy-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:r-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:tensorflow-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:datascience-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:pyspark-notebook
docker push  903030154846.dkr.ecr.us-west-2.amazonaws.com/wodeai-nb:all-spar-notebook


