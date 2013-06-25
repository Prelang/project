# ================================================
# ZSH->PROJECT ===================================
# ================================================
export PATH=$PATH:$(dirname $0)/bin

# Prefer project/
if [[ -d project/ ]] ; then
  _project_path=project/

# Fallback to bin/
else
  _project_path=bin/
fi

_project_cpl() {
  reply=()
  for file in `ls $_project_path`
  do
    reply[$(($#reply+1))]=$file
  done
}

compctl -K _project_cpl project

