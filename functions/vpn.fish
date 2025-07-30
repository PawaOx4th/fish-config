# Defined via `source`
function vpn --wraps=cls --description 'vpn close or open'
  switch $argv
    case close
      echo "Closing VPN..."
      launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*
      # Command to close VPN goes here
    case open
      echo "Opening VPN..."
      launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangp*
      # Command to open VPN goes here
    case '*'
      echo "Usage: vpn [close|open]"
    end
end

