# ================================================
# ZSH->PROJECT ===================================
# ================================================
export PATH=$PATH:$(dirname $0)/bin

_project_cpl() {

  # Default to bin/
  _project_path="bin/"

  # If bin/ doesn't exist, try for project/
  if [[ ! -d $_project_path ]] ; then
    if [[ -d "project/" ]] ; then
      _project_path="project/"
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

