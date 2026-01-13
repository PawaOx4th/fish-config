function commit_url_with_message
    # set pr $argv[1]
    
    # if test -z "$pr"
    #     echo "🔢 Enter PR number:"
    #     read pr
    # end
    
    set remote_url (git remote get-url origin)
    set repo (echo $remote_url | sed 's/.*github\.com[\/:]//; s/\.git$//')
    set hash (git log -n 1 --pretty=format:"%H")
    set short_hash (echo $hash | cut -c1-6)
    set commit_msg (git log -n 1 --pretty=format:"%s")
      #  set url "https://github.com/$repo/pull/$pr/commits/$hash"
    set url "https://github.com/$repo/commit/$hash"
    set url_with_msg "$commit_msg > $url"
    
    echo "┌─────────────────────────────────────┐"
    echo "│ 🔖 Hash: $short_hash"
    echo "│ 💬 Message: $commit_msg"
    echo "│ 🔗 Repo: $repo"
    echo "│ 👨🏼‍💻 Text: $url_with_msg"
    echo "└─────────────────────────────────────┘"
    echo $url_with_msg | pbcopy
    echo "✅ URL copied to clipboard!"
end