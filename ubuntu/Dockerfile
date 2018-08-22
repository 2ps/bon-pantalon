FROM ubuntu:bionic
ENV container=docker
ARG work_dir=/work
ARG username=2ps
ENV python3_version=3.6.6
ENV python2_version=2.7.15
VOLUME /u
# I found that when building on my local machine, the
# apt stuff was running very slowly.  I cheated and used a
# mirror that I knew would be close to my house in order
# to speed things up
#RUN cp /etc/apt/sources.list /etc/apt/sources.list.orig \
  #&& sed -i -e 's/archive.ubuntu.com/mirror.sjc02.svwh.net/' /etc/apt/sources.list \
  #&& sed -i -e 's/security.ubuntu.com/mirror.sjc02.svwh.net/' /etc/apt/sources.list \
#
# Install a bunch of stuff from apt that we use to build
# other pip requirements and do things like run the dev
# server in node
RUN apt-get -y update \
  && echo "America/Chicago" >/etc/timezone \
  && apt-get -y install \
        software-properties-common python-software-properties \
        vim zsh zip unzip wget curl libcurl4-openssl-dev \
        libssl-dev libffi-dev libxml2-dev libxslt1-dev \
        openssl libssl-doc g++ gcc apt-transport-https \
        git redis libmysqlclient-dev sqlite3 libsqlite3-dev \
        htop vim tmux libjpeg-dev libjpeg-turbo8-dev libfreetype6-dev \
        libncurses5-dev libreadline-dev libz3-dev less \
        make automake autoconf nfs-common bind9utils rsync gnupg \
        libldap2-dev libsasl2-dev build-essential checkinstall \
        libreadline7 libreadline-dev libncursesw5-dev tk-dev libgdbm-dev libc6-dev \
        git-crypt traceroute dnsutils net-tools nodejs \
  && mkdir -p /u/downloads \
  && function build_python {
        version="$1"
        mkdir -p ${work_dir}/downloads
        cd ${work_dir}/downloads
        filename="${work_dir}/downloads/python-$version.tgz"
        if [[ ! -f "$filename" ]] ; then
            wget "https://www.python.org/ftp/python/${version}/Python-${version}.tgz" -O "$filename" ;
        fi
        pdir="/u/python-$version"
        if [ ! -d "$pdir" ] ; then
            mkdir -p "$pdir"
            cd "$pdir"
            tar xzf "/u/downloads/python-$version.tgz" --strip-components=1
        fi
        cd "$pdir"
        ./configure && make && make altinstall
        rm -rf "$pdir"
    } \
  && build_python "${python2_version}" \
  && build_python "${python3_version}" \
  && if [ ! -d /u/dotfiles ] ; then cd ${work_dir} ; git clone https://github.com/2ps/dotfiles ; fi \
  && pip install -U pip ansible awscli ipython \
  && curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - \
  && sudo wget https://packages.microsoft.com/config/ubuntu/18.04/prod.list -O "/etc/apt/sources.list.d/mssql-release.list" \
  && sudo apt update \
  && sudo ACCEPT_EULA=Y apt -y install msodbcsql17 mssql-tools \
  && sudo apt install -y unixodbc-dev pv \
  && cd ${work_dir}/dotfiles \
  && ./ubuntu-install
RUN adduser --shell /bin/zsh --gecos "" --disabled-password --force-badname "${username}" \
  && echo "${username}  ALL=(ALL:ALL)  NOPASSWD: ALL" >/etc/sudoers.d/10-local-user \
  && chmod 0440 /etc/sudoers.d/10-local-user \
  && chown -R "${username}":"${username}" "${work_dir}" \
  && chmod 0755 "${work_dir}" \
  && cd ${work_dir}/dotfiles \
  && ./ubuntu-install ${username}
USER ${username}
