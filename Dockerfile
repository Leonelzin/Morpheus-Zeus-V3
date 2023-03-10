FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
	libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev \
	libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
	sudo git-core ca-certificates libncurses5-dev libgdbm-dev libnss3-dev \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m build && echo 'build ALL=NOPASSWD: ALL' > /etc/sudoers.d/build 
RUN ln -sf /bin/bash /bin/sh
WORKDIR /home/build
USER build

RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
ENV PYENV_ROOT /home/build/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN cd /home/build

RUN pyenv install 3.8.5 
RUN pyenv global 3.8.5 

RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
ENV PATH /home/build/.poetry/bin:$PATH
RUN poetry config virtualenvs.in-project true

