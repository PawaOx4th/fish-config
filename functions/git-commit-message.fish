# Defined via `source`
function gm --wraps=cls --description 'git commit with MESSAGE'
  git commit -m "$argv[1]"
  
  echo  "
  ==================================================
  🐙 Usage commit message :  $argv[1]
  ==================================================
  "
end

