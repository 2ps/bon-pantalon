FROM xxyy/centos:0.1
ARG name=xxyy/centos-pyenv
ARG version
ARG python2=2.7.14
ARG python3=3.6.3
ENV docker "${name}:${version}"
ARG work_dir=/work
ENV work_dir "${work_dir}"
VOLUME /u
USER root
WORKDIR "${work_dir}"
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
  && yum updateinfo && sudo yum makecache fast \
  && yum -y install git2u openssl-devel libffi-devel \
        sqlite-devel libjpeg-turbo-devel \
        freetype-devel zlib-devel bzip2-devel gcc gcc-c++ \
        make autoconf ncurses-devel readline-devel gdbm-devel \
        glibc-devel libdb-devel lz4-devel xz-devel \
        libxml2-devel libxslt-devel \
  && git clone https://github.com/pyenv/pyenv.git "${work_dir}/pyenv" \
  && git clone https://github.com/pyenv/pyenv-virtualenv.git "${work_dir}/pyenv/plugins/pyenv-virtualenv" \
  && echo 'export PYENV_ROOT=''"'"${work_dir}"'/pyenv''"' >> ~/.zshrc \
  && echo 'export PATH="${PYENV_ROOT}/bin":$PATH' >> ~/.zshrc \
  && echo 'eval "$(pyenv init -)"' >> ~/.zshrc \
  && echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc \
  && echo 'export PYENV_SHELL=zsh' >> ~/.zshrc  \
  && export PYENV_ROOT="${work_dir}/pyenv" \
  && export PATH="${work_dir}/pyenv/bin":$PATH \
  && eval "$(pyenv init -)" \
  && eval "$(pyenv virtualenv-init -)" \
  && pyenv install "${python2}" \
  && pyenv install "${python3}" \
  && yum -y remove git2u openssl-devel libffi-devel \
        sqlite-devel libjpeg-turbo-devel \
        freetype-devel zlib-devel bzip2-devel gcc gcc-c++ \
        make autoconf ncurses-devel readline-devel gdbm-devel \
        glibc-devel libdb-devel lz4-devel xz-devel \
        libxml2-devel libxslt-devel \
  && yum -y remove ius-release \
  && yum clean all \
  && rm -rf /var/yum/cache
WORKDIR /u
CMD [ "/entrypoint.sh" ]
