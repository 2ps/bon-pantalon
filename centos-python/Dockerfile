FROM xxyy/centos:0.1
ARG name=xxyy/centos-python
ARG version
ENV docker "${name}:${version}"
VOLUME /u
USER root
RUN yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
  && yum updateinfo && sudo yum makecache fast \
  && yum -y install git2u python27u python36u \
        python27u-devel python36u-devel \
  && pip install --no-cache-dir -U awscli virtualenv virtualenvwrapper \
  && yum -y remove ius-release \
  && yum clean all \
  && rm -rf /var/yum/cache
WORKDIR /u
CMD [ "/entrypoint.sh" ]
