FROM centos:centos7
ARG name=pshingavi/centos
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
  && yum updateinfo \
  && yum makecache fast \
  && yum -y install zip unzip tar gzip gunzip wget python-pip \
  && yum -y install openssl openssh \
  && pip install --no-cache-dir -U pip virtualenv \
  && yum -y install htop zsh git2u rsync sudo \
  && yum -y install vim python27u python36u pv \
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
  && pip install --no-cache-dir virtualenv virtualenvwrapper \
  && echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc \
  && echo "autoload -U compinit && compinit" >> ~/.zshrc \
  && echo "setopt no_beep" >> ~/.zshrc \
  && echo "set number" >> /etc/vimrc \
  && echo "set t_vb=" >> /etc/vimrc \
  && cp "${work_dir}"/dircolors ~/.dircolors \
  && echo "eval $(dircolors -b ~/.dircolors) ;" >> ~/.zshrc \
  && pip install --no-cache-dir virtualenv virtualenvwrapper \
  && pip install --no-cache-dir -U pip awscli \
  && sed -i -e 's,^\#set bell-style none$,set bell-style none,g' /etc/inputrc \
  && cd "${work_dir}" \
  && yum clean all \
  && rm -rf ~/.cache \
  && echo "${docker}" > /etc/docker.conf \
  && cat /etc/docker.conf
USER "${username}"
RUN sh -c "${work_dir}/downloads/install-zsh.sh || true" \
  && echo 'fpath=(~/.zsh/completions $fpath)' >> ~/.zshrc \
  && echo "autoload -U compinit && compinit" >> ~/.zshrc \
  && echo "setopt no_beep" >> ~/.zshrc \
  && cp "${work_dir}"/dircolors ~/.dircolors \
  && echo 'eval $(dircolors -b ~/.dircolors) ;' >> ~/.zshrc
COPY entrypoint.sh /
WORKDIR /u
CMD [ "/entrypoint.sh" ]
