FROM centos:centos7
ARG name=xxyy/centos
ARG version
ENV container docker
ENV docker "${name}:${version}"
ENV SODIUM_INSTALL system
ARG username=2ps
ARG work_dir=/work
VOLUME /u
WORKDIR "${work_dir}"
COPY dircolors .
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
      http://www.city-fan.org/ftp/contrib/yum-repo/city-fan.org-release-1-13.rhel7.noarch.rpm \
  && yum updateinfo && yum makecache fast \
  && yum -y install zip unzip tar gzip gunzip \
      curl wget python-pip openssl openssh \
      htop zsh rsync sudo vim pv git2u \
  && pip install --no-cache-dir -U pip virtualenv \
  && useradd ${username} \
  && echo "${username}  ALL=(ALL:ALL)  NOPASSWD: ALL" >/etc/sudoers.d/10-local-user \
  && chmod 0440 /etc/sudoers.d/10-local-user \
  && mkdir -p "${work_dir}/downloads" \
  && chmod 0777 "${work_dir}" \
  && chown -R "${username}":"${username}" "${work_dir}" \
  && cd "${work_dir}/downloads" \
  && chsh -s /bin/zsh \
  && pip install --no-cache-dir -U pip \
  && cp "${work_dir}"/dircolors ~/.dircolors \
  && sed -i -e 's,^\#set bell-style none$,set bell-style none,g' /etc/inputrc \
  && cd "${work_dir}" \
  && git clone https://github.com/2ps/dotfiles.git \
  && cd dotfiles \
  && chmod a+x ./centos-install \
  && ./centos-install \
  && ./centos-install "${username}" \
  && cd .. \
  && rm -rf dotfiles \
  && yum -y remove git2u city-fan.org-release ius-release \
  && yum clean all \
  && rm -rf ~/.cache \
  && rm -rf /var/cache/yum \
  && echo "${docker}" > /etc/docker.conf \
  && cat /etc/docker.conf
USER "${username}"
COPY entrypoint.sh /
WORKDIR /u
CMD [ "/entrypoint.sh" ]
