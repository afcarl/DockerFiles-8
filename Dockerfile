FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04 

COPY 00no-pipeline /etc/apt/apt.conf.d/00no-pipeline

####################################
# Apt libraries
####################################
RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list
RUN apt-get update && apt-get install -y \
         build-essential \
         apt-utils \
         cmake \
         git \
         less \
         zsh \
         curl \
         vim \
         graphviz \
         locales \
         libice6 \
         libsm6 \
         libxt6 \
         libxrender1 \
         libglu1-mesa-dev \
         libglib2.0-dev \
         libfontconfig1 \
         ca-certificates \
         libnccl2=2.0.5-2+cuda8.0 \
         libnccl-dev=2.0.5-2+cuda8.0 \
         libjpeg-dev \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*

WORKDIR /home
ENV HOME /home

###################################
# Anaconda + python deps
###################################
RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /home/miniconda3 && \     
     rm ~/miniconda.sh && \
     /home/miniconda3/bin/conda install -y python==3.6.2 && \     
     /home/miniconda3/bin/conda install -y theano==0.9\
                                           numpy==1.12.1\
                                           pyyaml==3.12\
                                           scipy==1.0.0\
                                           ipython==6.2.1 \
                                           jupyter\
                                           matplotlib==2.0.2\
                                           h5py==2.7.0\
                                           natsort==5.1.0\
                                           opencv==3.1.0\
                                           colorama==0.3.9\
                                           tqdm==4.19.4\
                                           scikit-learn==0.19\
                                           && \
     /home/miniconda3/bin/conda install -y keras==2.0.8 --no-deps &&\
     /home/miniconda3/bin/pip install terminaltables==3.1.0 \
                                      parmap==1.4.0 \
                                      pydot-ng==1.0.0 \
                                      pydot==1.2.3 \
                                      graphviz==0.8.1 &&\
     /home/miniconda3/bin/conda install pytorch==0.2.0 cuda80 -c soumith

####################################
# Keras and theano config files
####################################
WORKDIR /home/.keras
COPY keras.json ${HOME}/.keras
WORKDIR /home
COPY theano ${HOME}/.theanorc

####################################
# Set up locale to avoid zsh errors
####################################
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen --purge --lang en_US \
    && locale-gen
ENV LANG en_US.utf8

####################################
# Set up oh my zsh
####################################
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
COPY zshrc ${HOME}/.zshrc
RUN sed -i 's/❯/Docker❯/g' /home/.oh-my-zsh/themes/refined.zsh-theme
CMD ["/bin/zsh"]
