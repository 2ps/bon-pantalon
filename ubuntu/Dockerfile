FROM ubuntu:bionic
ENV container=docker
ARG name=xxyy/ubuntu
ARG version
ARG work_dir=/work
ENV docker "${name}:${version}"
ARG username=2ps
ENV python3_version=3.6.6
ENV python2_version=2.7.15
VOLUME /u
WORKDIR ${work_dir}
RUN echo "${docker}" > /etc/docker.conf \
  && apt-get -qq update \
  && echo "America/Chicago" >/etc/timezone \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq install apt-utils \
  && DEBIAN_FRONTEND=noninteractive apt-get install \
        software-properties-common htop lsof \
        vim zsh zip unzip wget curl libcurl4-openssl-dev sudo \
        libssl-dev libffi-dev libxml2-dev libxslt1-dev \
        openssl libssl-doc g++ gcc apt-transport-https \
        git redis libmysqlclient-dev sqlite3 libsqlite3-dev \
        htop vim tmux libjpeg-dev libjpeg-turbo8-dev libfreetype6-dev \
        libncurses5-dev libreadline-dev libz3-dev less \
        make automake autoconf nfs-common bind9utils rsync gnupg \
        libldap2-dev libsasl2-dev build-essential checkinstall \
        libreadline7 libreadline-dev libncursesw5-dev tk-dev libgdbm-dev libc6-dev \
        git-crypt traceroute dnsutils net-tools nodejs -qq >/dev/null
SHELL [ "/bin/bash", "-c" ]
RUN mkdir -p ${work_dir}/downloads \
  && echo "building python $python2_version" \
  && cd ${work_dir}/downloads \
  && filename="${work_dir}/downloads/python-${python2_version}.tgz" \
  && wget --quiet "https://www.python.org/ftp/python/${python2_version}/Python-${python2_version}.tgz" -O "$filename" \
  && pdir="${work_dir}/python-${python2_version}" \
  && mkdir -p $pdir && cd $pdir \
  && tar xzf "$filename" --strip-components=1 \
  && ./configure >/dev/null 2>&1 \
  && make >/dev/null 2>&1 \
  && make altinstall >/dev/null 2>&1 \
  && cd ${work_dir} \
  && rm -f "$filename" \
  && rm -rf "$pdir" \
  && echo "building python $python3_version" \
  && cd ${work_dir}/downloads \
  && filename="${work_dir}/downloads/python-${python3_version}.tgz" \
  && wget --quiet "https://www.python.org/ftp/python/${python3_version}/Python-${python3_version}.tgz" -O "$filename" \
  && pdir="${work_dir}/python-${python3_version}" \
  && mkdir -p $pdir && cd $pdir \
  && tar xzf "$filename" --strip-components=1 \
  && ./configure >/dev/null 2>&1 \
  && make >/dev/null 2>&1 \
  && make altinstall >/dev/null 2>&1 \
  && cd ${work_dir} \
  && rm -f "$filename" \
  && rm -rf "$pdir"
RUN cd ${work_dir} \
  && git clone https://github.com/2ps/dotfiles \
  && pip3.6 install -q -U pip awscli \
  && rm -rf ~/.cache \
  && curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl -s https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && DEBIAN_FRONTEND=noninteractive apt-get -qq update >/dev/null \
  && ACCEPT_EULA=Y DEBIAN_FRONTEND=noninteractive apt-get -qq install msodbcsql17 mssql-tools >/dev/null \
  && DEBIAN_FRONTEND=noninteractive apt-get install -qq unixodbc-dev pv >/dev/null \
  && cd ${work_dir}/dotfiles \
  && cp /etc/hosts /etc/hosts.orig \
  && echo "127.0.0.1    `hostname`" >/etc/hosts \
  && ./ubuntu-install \
  && echo "done with dotfiles" \
  && adduser --shell /bin/zsh --gecos "" --disabled-password --force-badname "${username}" \
  && echo "${username}  ALL=(ALL:ALL)  NOPASSWD: ALL" >/etc/sudoers.d/10-local-user \
  && chmod 0440 /etc/sudoers.d/10-local-user \
  && chown -R "${username}":"${username}" "${work_dir}" \
  && chmod 0755 "${work_dir}" \
  && cd ${work_dir}/dotfiles \
  && ./ubuntu-install ${username} \
  && mv -f /etc/hosts.orig /etc/hosts
USER ${username}
WORKDIR /u
CMD [ "/bin/zsh" ]
