cask "flowlight" do
  version "0.18.10"
  sha256 "2921fb518179f4112de970198e3e2b29b87cb9a34df7c9b038a7705e981f432d"

  url "https://github.com/xinbetween/flowlight/releases/download/v#{version}/Flowlight.dmg"
  name "Flowlight"
  desc "Network monitor for apps, domains and AI agents"
  homepage "https://flowlight.xinbetween.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Flowlight.app"

  # The app stanza removes Flowlight itself; this only makes sure it isn't running first.
  uninstall quit: "com.flowlight.app"

  # History, settings and caches. The content filter and the inspection certificate authority are installed by
  # macOS on the app's request, so only the app can withdraw them — hence the caveat.
  zap trash: [
    "~/Library/Application Support/Flowlight",
    "~/Library/Caches/com.flowlight.app",
    "~/Library/HTTPStorages/com.flowlight.app",
    "~/Library/Preferences/com.flowlight.app.plist",
    "~/Library/Saved Application State/com.flowlight.app.savedState",
  ]

  caveats <<~EOS
    If you turned on the network extension or HTTPS inspection, open Flowlight and switch them off
    before uninstalling: only the app itself can remove the system extension and the certificate it
    added to your login keychain.
  EOS
end
