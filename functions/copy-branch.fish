# Defined via `source`
function copybranch --wraps=copybranch --description 'git branch --show-current | pbcopy'
  git branch --show-current | pbcopy
end

