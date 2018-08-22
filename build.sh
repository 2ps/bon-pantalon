#!/usr/bin/env bash
x="${1}"
dirname="${x}"
version=$(cat "${dirname}/VERSION")
name=$(cat "${dirname}/NAME")
if [ -f ${x}/prebuild.sh ] ; then
    /bin/bash "${x}/prebuild.sh" "${x}";
fi
docker.exe build \
  --build-arg name="${name}" \
  --build-arg version="${version}" \
  --tag "${name}":latest \
  --tag "${name}:${version}" \
  "${x}"
if [ -f ${x}/postbuild.sh ] ; then
    echo "calling "${x}/postbuild.sh" . . ."
    /bin/bash "${x}/postbuild.sh" "${x}";
fi
