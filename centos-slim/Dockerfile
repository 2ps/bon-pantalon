FROM centos:centos7
ARG name=xxyy/centos
ARG version
ENV container docker
ENV docker "${name}:${version}"
ARG git_version=2.18.0
ARG username=2ps
ARG work_dir=/work
VOLUME /u
RUN yum -y install http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-2-1.rhel7.noarch.rpm \
  && yum -y install epel-release \
  && yum updateinfo && yum makecache fast \
  && yum -y install zip unzip tar gzip \
      curl libcurl-devel wget python-pip openssl openssh \
      htop zsh rsync sudo vim pv autoconf \
      dh-autoreconf curl-devel expat-devel gettext-devel gcc \
      openssl-devel perl-devel zlib-devel \
  && useradd ${username} \
  && echo "${username}  ALL=(ALL:ALL)  NOPASSWD: ALL" >/etc/sudoers.d/10-local-user \
  && chmod 0440 /etc/sudoers.d/10-local-user \
  && mkdir -p "${work_dir}/downloads" \
  && chmod 0777 "${work_dir}" \
  && chown -R "${username}":"${username}" "${work_dir}" \
  && cd "${work_dir}/downloads" \
  && wget "https://www.kernel.org/pub/software/scm/git/git-${git_version}.tar.gz" -O "${work_dir}/downloads/git-${git_version}.tgz" \
  && mkdir -p ${work_dir}/git-${git_version} \
  && pushd ${work_dir}/git-${git_version} \
  && tar xzf "${work_dir}/downloads/git-${git_version}.tgz" --strip-components=1 \
  && make configure \
  && ./configure --prefix=/usr \
  && make all \
  && make install \
  && popd \
  && rm -rf ${work_dir}/git-${git_version} \
  && pip install --no-cache-dir -U pip virtualenv \
  && chsh -s /bin/zsh \
  && sed -i -e 's,^\#set bell-style none$,set bell-style none,g' /etc/inputrc \
  && cd "${work_dir}" \
  && git clone https://github.com/2ps/dotfiles.git \
  && cd dotfiles \
  && echo "${docker}" > /etc/docker.conf \
  && chmod a+x ./centos-install \
  && ./centos-install \
  && ./centos-install "${username}" \
  && cd .. \
  && rm -rf dotfiles \
  && yum -y remove city-fan.org-release \
  && yum clean all \
  && rm -rf ~/.cache \
  && rm -rf /var/cache/yum
USER "${username}"
WORKDIR /u
CMD [ "/bin/zsh" ]
