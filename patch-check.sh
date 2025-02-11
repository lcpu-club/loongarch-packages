#!/bin/bash

source /usr/share/makepkg/util/message.sh

if [[ -e loong.patch ]]; then
  error "loong.patch is found in root directory."
  exit 1
fi

ORIGDIR=$PWD
for _dir in $(git diff --merge-base --name-only upstream/master | cut -d / -f 1 | uniq); do
  if [[ ! -e "$_dir"/loong.patch ]]; then
    echo "Skipping $_dir..."
    continue
  fi

  echo "Trying to apply patch for $_dir..."

  pushd $_dir
  _tmp=$(sudo -u nobody mktemp -d)
  cd $_tmp

  PKGBASE=$_dir
  if ! sudo -u nobody git clone https://gitlab.archlinux.org/archlinux/packaging/packages/$PKGBASE.git; then
    # These are packages with `loong.patch` but not in x86 repo
    # which means the $PKGBASE is wrong (our own maintained packages doesn't have `looong.patch`)
    error "Cannot clone Arch Linux repository of $PKGBASE, probably the pkgbase is wrong."
    exit 1
  fi
  cd $PKGBASE

  PKGNAME_ARRAY=($(source PKGBUILD > /dev/null; echo "${pkgname[@]}"))
  # find any available package name in PKGNAME_ARRAY
  for _REPO in core extra; do
    _cache="$(pacman -Sql $_REPO)" # quatation ihere is required since it's multi-line
    for PKGNAME in "${PKGNAME_ARRAY[@]}"; do
      if echo "$_cache" | grep -xF "$PKGNAME" > /dev/null; then
        REPO=$_REPO
        break 2
      fi
    done
  done

  if [[ -z "$REPO" ]]; then
    # Actually triggers for rotten packages
    error "Cannot find package in x86 repo."
    exit 1
  fi

  LATEST_VERSION=$(expac -S %v $PKGNAME)
  if ! sudo -u nobody git checkout ${LATEST_VERSION/:/-}; then
    error "Repository does not contain tag of latest non-testing version $LATEST_VERSION."
    exit 1
  fi

  cp $ORIGDIR/$PKGBASE/* ./

  sudo -u nobody patch -p1 -i ./loong.patch || exit 1

  sudo -u nobody makepkg --verifysource --skippgpcheck || exit 1

  popd
done
