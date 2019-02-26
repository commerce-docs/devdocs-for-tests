#!/usr/bin/env bash
docs_from_code () {
  local dir=$1
  local repo=$2
  local branch=$3
  local token=$4

  local ssh=git@github.com:
  local https=https://"$token"@github.com/
  local org=magento-devdocs

  if "$token"
        then
    protocol=$https
  else 
    protocol=$ssh
  fi

  mkdir "$dir"
  cd "$dir" || exit
  git init
  git remote add origin -f "$protocol""$org"/"$repo".git;
  git config core.sparseCheckout true

  echo '/docs/*' >> .git/info/sparse-checkout

  git checkout "$branch"
  cd ..
}

docs_from_code mftf magento2-functional-testing-framework docs-in-code
docs_from_code page-builder magento2-page-builder ds_docs-in-code "$token"
