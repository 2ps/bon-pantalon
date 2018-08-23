#!/usr/bin/env bash
function build_python {
    version="$1"
    mkdir -p ${work_dir}/downloads
    cd ${work_dir}/downloads
    filename="${work_dir}/downloads/python-$version.tgz"
    if [[ ! -f "$filename" ]] ; then
        wget "https://www.python.org/ftp/python/${version}/Python-${version}.tgz" -O "$filename" ;
    fi
    pdir="${work_dir}/python-$version"
    if [ ! -d "$pdir" ] ; then
        mkdir -p "$pdir"
        cd "$pdir"
        tar xzf "${work_dir}/downloads/python-$version.tgz" --strip-components=1
    fi
    cd "$pdir"
    ./configure && make && make altinstall
    cd ..
    rm -f "$filename"
    rm -rf "$pdir"
}
