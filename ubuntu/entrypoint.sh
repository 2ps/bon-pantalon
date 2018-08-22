#!/bin/zsh
for x in .ssh .aws .gnupg ; do
  if [ -d "/u/secrets/${x}" ] ; then
    cp -R "/u/secrets/${x}" ~ ;
    chmod 0700 ~/${x}
    find ~/${x} -type f -exec chmod 0600 {} \;
    find ~/${x} -type d -exec chmod 0700 {} \;
  fi
done
/bin/zsh
