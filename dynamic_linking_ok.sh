#!/bin/sh
# dynamic_linking_ok.sh
# Charlotte Koch <cfkoch@edgebsd.org>

for path in $(echo ${PATH} | tr : "\n"); do
  for prog in $(find ${path} -type f); do
    for dylib in $(ldd -f "%p\n" ${prog}); do
      if [ -f ${dylib} ]; then
        if [ "$1" = "-v" -o "$1" = "--verbose" ]; then
          echo "OK ${prog} => ${dylib}" 2>&1 
        fi
      else
        echo "UNKNOWN${prog} => ${dylib}" 2>&1
      fi
    done
  done
done
