
function go --wraps go --description "go to work" 
  switch $argv
    case web1
      cd ~/Desktop/PawaOx4th/work/WEB/kpc-web-frontend
    case web2
      cd ~/Desktop/PawaOx4th/work/WEB/kpc-web-frontend-2
    case '*'
      echo I have no idea what a $animal is
  end
end

