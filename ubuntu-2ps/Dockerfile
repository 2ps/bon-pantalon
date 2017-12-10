FROM ubuntu:xenial
ENV container=docker
ARG work_dir=/u
ARG username=2ps
ENV python3_version=3.6.3
ENV python2_version=2.7.14
# I found that when building on my local machine, the
# apt stuff was running very slowly.  I cheated and used a
# mirror that I knew would be close to my house in order
# to speed things up
RUN cp /etc/apt/sources.list /etc/apt/sources.list.orig \
  && sed -i -e 's/archive.ubuntu.com/mirror.sjc02.svwh.net/' /etc/apt/sources.list \
  && sed -i -e 's/security.ubuntu.com/mirror.sjc02.svwh.net/' /etc/apt/sources.list \

# Install a bunch of stuff from apt that we use to build
# other pip requirements and do things like run the dev
# server in node
  && apt-get -y update \
  && apt-get -y install software-properties-common python-software-properties \
  && add-apt-repository -y ppa:git-core/ppa \
  && apt-get -y install vim zsh zip unzip wget curl libcurl4-openssl-dev \
        libssl-dev libffi-dev libxml2-dev libxslt1-dev \
        openssl libssl-doc g++ gcc apt-transport-https \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" >/etc/apt/sources.list.d/yarn.list \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get -y install acl build-essential htop jq libc6 libevent-dev \
        libffi6 libgraphviz-dev libjpeg-dev libmagic-dev \
        libpq-dev libpq-dev libxml2 ntp pkg-config \
        postgresql-client python-geoip python-pip \
        python-pycurl python-setuptools supervisor zlib1g-dev \
        sudo libtiff-dev python-pip make libbz2-dev libreadline-dev \
        libsqlite3-dev automake libtool libmagic-dev nodejs git \
        poppler-utils ghostscript ruby rsync libsodium-dev \

# Build sassc and libsass
  && cd /tmp \
  && git clone https://github.com/sass/libsass.git \
  && git clone https://github.com/sass/sassc.git  \
  && cd libsass \
  && autoreconf --force --install \
  && ./configure --disable-tests --enable-shared --prefix=/usr \
  && cd .. \
  && make -C libsass -j4 \
  && make -C libsass install \
  && cd sassc \
  && autoreconf --force --install \
  && ./configure --enable-shared --prefix=/usr \
  && cd .. \
  && make -C sassc -j4 \
  && make -C sassc install \
  && cd /tmp \
  && rm -rf ./libsass \
  && rm -rf ./libsass ./sassc \
  && apt-get -y clean \
# confirm git and sassc versions
  && git --version \
  && sassc --version
RUN mkdir -p "${work_dir}/downloads" \
  && cd "${work_dir}/downloads" \
  && chsh -s /bin/zsh \
  && curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | grep -v 'env zsh' >"${work_dir}/downloads/install-zsh.sh" \
  && chmod a+x "${work_dir}/downloads/install-zsh.sh" \
  && sh -c "${work_dir}/downloads/install-zsh.sh || true" \
  && pip install -U pip \
  && pip install virtualenv \
  && git clone https://github.com/pyenv/pyenv.git "${work_dir}/pyenv" \
  && git clone https://github.com/pyenv/pyenv-virtualenv.git "${work_dir}/pyenv/plugins/pyenv-virtualenv" \
  && echo 'export PYENV_ROOT=''"'"${work_dir}"'/pyenv''"' >> ~/.zshrc \
  && echo 'export PATH="${PYENV_ROOT}/bin":$PATH' >> ~/.zshrc \
  && echo 'eval "$(pyenv init -)"' >> ~/.zshrc \
  && echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc \
  && echo 'export PYENV_SHELL=zsh' >> ~/.zshrc  \
  && wget -q https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz -O "${work_dir}/downloads/hub-2.2.9.tgz" \
  && cd "${work_dir}" \
  && mkdir -p hub-2.2.9 \
  && cd hub-2.2.9 \
  && tar xzf ../downloads/hub-2.2.9.tgz --strip-components=1 \
  && ./install \
  && mv ./etc/hub.zsh_completion ../downloads/ \
  && echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc \
  && echo "autoload -U compinit && compinit" >> ~/.zshrc \
  && echo 'eval "$(hub alias -s zsh)"' >> ~/.zshrc  \
  && rm -rf ../downloads/hub-2.2.9.tgz \
  && cd "${work_dir}" \
  && rm -rf hub-2.2.9
RUN adduser --shell /bin/zsh --gecos "" --disabled-password --force-badname "${username}" \
  && echo "${username}  ALL=(ALL:ALL)  NOPASSWD: ALL" >/etc/sudoers.d/10-local-user \
  && chmod 0440 /etc/sudoers.d/10-local-user \
  && chown -R "${username}":"${username}" "${work_dir}" \
  && chmod 0755 "${work_dir}" \
  && su - "${username}" "${work_dir}/downloads/install-zsh.sh" || true
USER ${username}
# the pyenv commands don't work with /bin/sh, so switch to
# our good ol' zsh
# https://stackoverflow.com/questions/20635472/using-the-run-instruction-in-a-dockerfile-with-source-does-not-work/42216046#42216046
SHELL [ "/bin/zsh", "-c" ]
RUN echo 'export PYENV_ROOT=''"'"${work_dir}"'/pyenv''"' >> ~/.zshrc \
  && echo 'export PATH="${PYENV_ROOT}/bin":$PATH' >> ~/.zshrc \
  && echo 'eval "$(pyenv init -)"' >>~/.zshrc \
  && echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc \
  && mkdir -p ~/.zsh/completions \
  && cp "${work_dir}/downloads/hub.zsh_completion" ~/.zsh/completions/_hub \
  && echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc \
  && echo "autoload -U compinit && compinit" >> ~/.zshrc \
  && echo 'eval "$(hub alias -s zsh)"' >> ~/.zshrc \
  && export PYENV_ROOT="${work_dir}/pyenv" \
  && export PATH="${PYENV_ROOT}/bin:$PATH" \
  && eval "$(pyenv init -)" \
  && eval "$(pyenv virtualenv-init -)" \
  && pyenv install "${python3_version}" \
  && pyenv install "${python2_version}" \
  && pyenv virtualenv "${python2_version}" ansible \
  && pyenv virtualenv "${python3_version}" eshares \
  && pyenv global "${python2_version}"
COPY entrypoint.sh /entrypoint.sh
USER ${username}
CMD [ "/entrypoint.sh" ]
