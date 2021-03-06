FROM centos:centos7
ARG name=xxyy/centos-ohmy
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
  && curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | grep -v 'env zsh' >"${work_dir}/downloads/install-zsh.sh" \
  && chmod a+x "${work_dir}/downloads/install-zsh.sh" \
  && sh -c "${work_dir}/downloads/install-zsh.sh || true" \
  && pip install --no-cache-dir -U pip \
  && echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc \
  && echo "autoload -U compinit && compinit" >> ~/.zshrc \
  && echo "setopt no_beep" >> ~/.zshrc \
  && echo "set number" >> /etc/vimrc \
  && echo "set t_vb=" >> /etc/vimrc \
  && cp "${work_dir}"/dircolors ~/.dircolors \
  && echo "eval \$(dircolors -b ~/.dircolors) ;" >> ~/.zshrc \
  && sed -i -e 's,^\#set bell-style none$,set bell-style none,g' /etc/inputrc \
  && cd "${work_dir}" \
  && yum -y remove git2u city-fan.org-release ius-release \
  && yum clean all \
  && rm -rf ~/.cache \
  && rm -rf /var/cache/yum \
  && echo "${docker}" > /etc/docker.conf \
  && cat /etc/docker.conf
USER "${username}"
RUN sh -c "${work_dir}/downloads/install-zsh.sh || true" \
  && echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc \
  && echo "autoload -U compinit && compinit" >> ~/.zshrc \
  && echo "setopt no_beep" >> ~/.zshrc \
  && cp "${work_dir}"/dircolors ~/.dircolors \
  && echo "eval \$(dircolors -b ~/.dircolors) ;" >> ~/.zshrc
COPY entrypoint.sh /
WORKDIR /u
CMD [ "/entrypoint.sh" ]
