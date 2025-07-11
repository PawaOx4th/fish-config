
function commit-id --wraps gui --description "Copy commit id 7 characters to clipboard" 
  set hash (git log -n 1 --pretty=format:"%H" | cut -c1-7)
  echo $hash | pbcopy
  echo "📋 Commit ID copied to clipboard <$hash> "
  echo "┌──────────────────────┐"
  echo "    🔗 Hash: $hash   "
  echo "└──────────────────────┘"
end

