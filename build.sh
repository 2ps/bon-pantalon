#!/usr/bin/env bash
x="${1}"
dirname="${x}"
version=$(cat "${dirname}/VERSION")
name=$(cat "${dirname}/NAME")
cp dircolors "${x}"
docker build \
  --build-arg name="${name}" \
  --build-arg version="${version}" \
  --tag "${name}":latest \
  --tag "${name}:${version}" \
  "${x}"
rm "${x}"/dircolors
