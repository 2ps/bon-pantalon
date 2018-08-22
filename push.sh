#!/usr/bin/env bash
x="${1}"
dirname="${x}"
version=$(cat "${dirname}/VERSION")
name=$(cat "${dirname}/NAME")
docker.exe push "${name}:latest"
docker.exe push "${name}:${version}"
