# ================================================
# ZSH->PROJECT ===================================
# ================================================
export PATH=$PATH:$(dirname $0)/bin
  
_project_path=project/

_project_cpl() {
  reply=()

  for file in `ls $_project_path`
  do
    reply[$(($#reply+1))]=$file
  done
}

compctl -K _project_cpl project

