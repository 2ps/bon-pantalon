FROM python:2.7.14-alpine3.6
ENV container docker
ENV SODIUM_INSTALL system
ARG work_dir=/work
VOLUME /u
WORKDIR "${work_dir}"
COPY NAME .
COPY VERSION .
RUN apk add --no-cache \
    zip unzip tar gzip wget \
    openssl openssh htop zsh git rsync \
    python3 pv curl \
  && pip install --no-cache-dir -U pip virtualenv \
  && mkdir -p "${work_dir}/downloads" \
  && chmod 0777 "${work_dir}" \
  && cd "${work_dir}/downloads" \
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
  && pip install --no-cache-dir virtualenv virtualenvwrapper \
  && pip install --no-cache-dir -U pip awscli \
  && cd "${work_dir}" \
  && rm -rf ~/.cache \
  && cat "${work_dir}/NAME" > /etc/docker.conf \
  && printf ":" >> /etc/docker.conf \
  && cat "${work_dir}/VERSION" >> /etc/docker.conf \
  && rm -rf "${work_dir}/VERSION" "${work_dir}/NAME" \
  && cat /etc/docker.conf \
  && rm -rf /var/cache/apk/*
COPY entrypoint.sh /
WORKDIR /u
CMD [ "/entrypoint.sh" ]
