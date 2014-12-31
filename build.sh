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
DIRS=()

# Files to cherry-pick
FILES=( "css/spinkit.css"
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
  git clone "$REPO" --branch ${VERSION} .git-repo >/dev/null 2>&1 || { echo "Error running: git clone $REPO --branch ${VERSION} .git-repo"; exit 1; }
  [ -f .gitignore ] && grep -q '^.git-repo$' .gitignore || echo ".git-repo" >> .gitignore
  [ -f .gitignore ] && grep -q '^.versions$' .gitignore || echo ".versions" >> .gitignore
  # Copy selected dirs from repo to lib
  mkdir -p lib
  if [ "${#DIRS[@]}" -ge 1 ]; then
    for dir in ${DIRS[@]}; do
      if [ -d ".git-repo/$dir" ]; then
        echo "  - Copying $dir"
        cp -Rf .git-repo/$dir lib || { echo "Error copying ./.git-repo/${dir} to ./lib"; exit 1; }
      fi
    done
  fi
  # Copy selected files from repo to lib
  if [ "${#FILES[@]}" -ge 1 ]; then
    for file in ${FILES[@]}; do
      if [ -f ".git-repo/$file" ]; then
        echo "  - Copying $file"
        cp -f ".git-repo/$file" lib || { echo "Error copying ./.git-repo/${file} to ./lib"; exit 1; }
      fi
    done
  fi
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
