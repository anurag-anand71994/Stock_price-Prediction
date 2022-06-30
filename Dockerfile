#creating base image
FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive


#
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
SHELL ["/bin/bash", "--login", "-c"]


RUN apt-get update
RUN yes |apt-get install wget
RUN yes | apt-get install curl
RUN cd /tmp



RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*


RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && /bin/bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

RUN conda --version

RUN conda install -c conda-forge python==3.8.2

VOLUME [ "/data/db" ]
WORKDIR /data

COPY ./shared_folder/requirements.txt ./
RUN conda install pip
RUN yes | pip install -r requirements.txt

#EXPOSE 8889
CMD [ "ls" ]

RUN yes | conda install -c anaconda jupyter
#RUN jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token=''

######################use below command to start docker with shred port and shared volume###################3
#docker run -it -p 8888:8888 -v D:/docker/docker2/shared_folder:/data d29958a3e6d2 sh 
#write below command to open juipyter notebook
#jupyter notebook --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token=''

