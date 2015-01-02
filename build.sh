#!/usr/bin/env bash
#
# Fetch and pick files from sources repo/version specified in package.js
#
# PCEL.com - MIT License
#
################################################################################
REPOS=(    $( grep -E 'source_git.*:' package.js | grep -Eo "http[^('|\")]+" ) )
VERSIONS=( $( grep -E 'source_ver.*:' package.js | sed -e 's/"//g' -e 's/,//g' -e 's/ //g' | cut -d: -f2 ) )

# Directories to preserve on package repositories (remove the rest)
ITEMS=( )

# Files to cherry-pick
ITEMS+=( "css/spinkit.css"
         "build/please-wait.css"
         "build/please-wait.js" )

################################################################################
# Chdir into script dir
cd -P "$( dirname "${BASH_SOURCE[0]}" )" || { echo "Can't chdir into package path" && exit 1; }

# Fetch a repo and pick a specified released version or branch
fetch_and_pick() {
  # Cleanup directories
  [ -d .git-repo ] && rm -Rf .git-repo
  # Clone repo
  git clone "$REPO" --branch "$VERSION" .git-repo >/dev/null 2>&1 || {
    echo "Error running: git clone $REPO --branch ${VERSION} .git-repo"
    exit 1
  }
  [ -f .gitignore ] && grep -q '^.git-repo$' .gitignore || echo ".git-repo" >> .gitignore
  [ -f .gitignore ] && grep -q '^.versions$' .gitignore || echo ".versions" >> .gitignore
  mkdir -p lib

  # Copy selected dirs/files from repo to lib
  for item in "${ITEMS[@]}"; do
    if [ -d ".git-repo/$item" -o -f ".git-repo/$item" ]; then
      echo "  - Copying $item"
      cp -Rf .git-repo/$item lib || { echo "Error copying ./.git-repo/$item to ./lib"; exit 1; }
    fi
  done
}

# Cleanup last build
[ -d lib ] && rm -Rf lib

# Fetch and pick each repo@version
for SEQ in $(seq 0 $(( ${#REPOS[@]} - 1)) ); do
  REPO=${REPOS[$SEQ]}
  VERSION=${VERSIONS[$SEQ]}
  echo "Downloading $REPO - $VERSION"
  fetch_and_pick
done

echo "All done"
################################################################################
