# ================================================
# ZSH->PROJECT ===================================
# ================================================
export PATH=$PATH:$(dirname $0)/bin

_project_cpl() {

  # Default to project/
  _project_path="project/"

  # If project/ doesn't exist, try for bin/
  if [[ ! -d $_project_path ]] ; then
    if [[ -d "bin/" ]] ; then
      _project_path="bin/"
    else
    fi
  fi

  reply=()

  for file in `ls $_project_path`
  do
    reply[$(($#reply+1))]=$file
  done
}

compctl -K _project_cpl project

