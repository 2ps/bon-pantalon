#!/usr/bin/env bash
x="${1}"
dirname="${x}"
version=$(cat "${dirname}/VERSION")
name=$(cat "${dirname}/NAME")
docker build -t "${name}":latest -t "${name}:${version}" "${x}"
