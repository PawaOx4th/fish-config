# Defined via `source`
function gu --wraps=cls --description 'git fetch origin -p && git pull origin -p'
  echo "⏳ Updating branch in local repository..."
  git fetch origin -p && git pull origin -p
end

