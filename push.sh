#!/usr/bin/env bash
x="${1}"
dirname="${x}"
version=$(cat "${dirname}/VERSION")
name=$(cat "${dirname}/NAME")
docker push "${name}:latest"
docker push "${name}:${version}"
