#!/bin/bash
__DIR__=$(cd "$(dirname "$0")" || exit 1; pwd); [ -z "${__DIR__}" ] && exit 1

error(){ echo "[ERROR] $1"; exit 1; }
success(){ echo "[SUCCESS] $1"; exit 0; }
info(){ echo "[INFO] $1";}

workdir="$1"

if ! cd "${workdir}"; then
  error "Cd to ${workdir} failed"
fi

info "Scanning dir \"${workdir}\" ..."

if [ ! -f "./Makefile" ] && [ ! -f "./CMakeLists.txt" ]; then
  error "Non-project dir ${workdir}"
fi

info "CMake build dir will be removed:"

rm -rf -v ./build

info "Following files will be removed:"

find ${workdir}/src/Zend -name zend_language_scanner.cc -print0 | xargs -0 rm -f -v
find ${workdir}/src/Zend -name zend_language_parser.h -print0 | xargs -0 rm -f -v
find ${workdir}/src/Zend -name zend_language_parser.cc -print0 | xargs -0 rm -f -v

success "Clean '${workdir}' done"
