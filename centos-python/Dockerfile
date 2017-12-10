FROM pshingavi/centos:0.3
ARG name=pshingavi/centos-python
ARG version
ENV docker "${name}:${version}"
ENV SODIUM_INSTALL system
ARG username=2ps
ARG work_dir=/work
VOLUME /u
WORKDIR "${work_dir}"
RUN sudo yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
  && sudo yum updateinfo && sudo yum makecache fast \
  && sudo yum -y install git2u python27u python36u \
        python27u-devel python36u-devel \
  && sudo pip install --no-cache-dir -U awscli virtualenv virtualenvwrapper \
COPY entrypoint.sh /
WORKDIR /u
CMD [ "/entrypoint.sh" ]
