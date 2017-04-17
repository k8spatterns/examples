#!/bin/sh

if [ "x$1" = "x-u" ]; then
  user=$2
  shift; shift;  
fi

inDir=$1
dataDir=$2
outDir=$3

function extract_datasources() {  
  local ret=""
  local key=""
  for data in $(ls ${dataDir}); do
    key=$(echo ${data} | sed -e 's/\.[^.]*$//')
    ret="${ret} --datasource ${key}=file://${dataDir}/${data}"
  done
  echo $ret
}

echo "Storing templates in ${outDir}"
for in in $(ls ${inDir}); do
  f="${inDir}/${in}"
  if [ -f "${f}" ]; then
    echo "Processing $f ..."
    out="${outDir}/${in}"
    cat ${f} | /gomplate $(extract_datasources) > "${out}"
    echo "cat ${f} | /gomplate $(extract_datasources) > ${out}"
    if [ "x${user}" != x ]; then
      chown "${user}" "${out}"
    fi
  fi
done
