FROM centos:centos7
ARG name=xxyy/centos
ARG version
ENV container docker
ENV docker "${name}:${version}"
ARG git_version=2.18.0
ARG username=2ps
ARG work_dir=/work
VOLUME /u
SHELL [ "/bin/bash", "-c" ]
RUN yum -y -q install http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-2-1.rhel7.noarch.rpm \
  && yum -y -q install epel-release \
  && yum -q updateinfo && yum -q makecache fast \
  && yum -y -q install --enablerepo=city-fan.org curl libcurl-devel \
  && yum -q -y remove city-fan.org-release \
  && yum -q clean all
RUN yum -q -y install ius-release \
  && yum -q -y install git2u \
  && yum -q clean all
RUN yum -q -y install zip unzip \
  && yum -y install wget python-pip openssl openssh \
  && yum -q clean all
RUN yum -y -q install htop zsh rsync sudo vim pv autoconf \
  && yum -q clean all
RUN yum -y -q install dh-autoreconf curl-devel expat-devel gettext-devel gcc \
  && yum -q clean all
RUN yum -y -q install openssl-devel perl-devel zlib-devel \
  && yum -q clean all
RUN useradd ${username} \
  && echo "${username}  ALL=(ALL:ALL)  NOPASSWD: ALL" >/etc/sudoers.d/10-local-user \
  && chmod 0440 /etc/sudoers.d/10-local-user \
  && mkdir -p "${work_dir}/downloads" \
  && chmod 0777 "${work_dir}" \
  && chown -R "${username}":"${username}" "${work_dir}"
RUN cd "${work_dir}/downloads" \
  && wget -q "https://www.kernel.org/pub/software/scm/git/git-${git_version}.tar.gz" -O "${work_dir}/downloads/git-${git_version}.tgz" \
  && mkdir -p ${work_dir}/git-${git_version} \
  && pushd ${work_dir}/git-${git_version} >/dev/null \
  && tar xzf "${work_dir}/downloads/git-${git_version}.tgz" --strip-components=1 \
  && make configure >/dev/null \
  && ./configure --prefix=/usr >/dev/null \
  && make all >/dev/null \
  && make install >/dev/null \
  && popd >/dev/null \
  && rm -f ${work_dir}/downloads/git-${git_version}.tgz \
  && rm -rf ${work_dir}/git-${git_version}
RUN pip install --no-cache-dir -q -U pip \
  && chsh -s /bin/zsh \
  && sed -i -e 's,^\#set bell-style none$,set bell-style none,g' /etc/inputrc \
  && cd "${work_dir}" \
  && git clone -q https://github.com/2ps/dotfiles.git \
  && cd dotfiles \
  && echo "${docker}" > /etc/docker.conf \
  && chmod a+x ./centos-install \
  && ./centos-install \
  && ./centos-install "${username}" \
  && cd .. \
  && rm -rf dotfiles \
  && yum -q -y remove city-fan.org-release \
  && yum -q clean all \
  && rm -rf ~/.cache \
  && rm -rf /var/cache/yum
USER "${username}"
RUN whoami
WORKDIR /u
CMD [ "/bin/zsh" ]
