#!/usr/bin/env bash
function build_python {
    version="$1"
    echo "building python $version"
    mkdir -p ${work_dir}/downloads
    cd ${work_dir}/downloads
    filename="${work_dir}/downloads/python-$version.tgz"
    if [[ ! -f "$filename" ]] ; then
        wget --quiet "https://www.python.org/ftp/python/${version}/Python-${version}.tgz" -O "$filename" ;
    fi
    pdir="${work_dir}/python-$version"
    if [ ! -d "$pdir" ] ; then
        mkdir -p "$pdir"
        cd "$pdir"
        tar xzf "${work_dir}/downloads/python-$version.tgz" --strip-components=1
    fi
    cd "$pdir"
    ./configure >/dev/null 2>&1
    make >/dev/null 2>&1
    make altinstall >/dev/null 2>&1
    cd ..
    rm -f "$filename"
    rm -rf "$pdir"
    echo "done"
}
