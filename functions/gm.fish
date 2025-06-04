
function gm --wraps=gc --description "git commit with message !" 

  set -l message (string join " " $argv)
    echo "============================================"
    echo "Usage: gm  $message"
    echo "- - - - - - - - - - - - - - - - - - - - - - "
  git commit -m "$message"
    echo "============================================"
 
end




