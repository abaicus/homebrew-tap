cask "gogu" do
  arch arm: "arm64", intel: "x64"

  version "0.2.0"
  sha256 arm:   "a25d0e9cfdfc71f3408bfd143c0e3ba3fd5542ec8d0797775ce2d1793749f8ad",
         intel: "7c2f29d8d96341b39fe6eab35be7594fb29f6411c298cda1635059b165ab5d4f"

  url "https://github.com/abaicus/gogu/releases/download/v#{version}/gogu-#{version}-#{arch}.zip"
  name "Gogu"
  desc "Desktop tamagotchi that feeds on Claude Code activity"
  homepage "https://github.com/abaicus/gogu"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :catalina

  app "Gogu.app"

  # Not signed with an Apple Developer ID, so Gatekeeper would quarantine it
  # into "damaged, move to Trash". The build IS ad-hoc signed and its checksum
  # is pinned above; this drops the quarantine flag on that verified download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Gogu.app"]
  end

  uninstall quit: "com.abaicus.gogu"

  # Not listed: ~/.claude/settings.json. The pet writes its hooks there and
  # removes exactly its own entries from the tray's uninstall — a zap that
  # rewrote your Claude config would be overreach.
  zap trash: [
    "~/.gogu",
    "~/Library/Application Support/Gogu",
    "~/Library/Preferences/com.abaicus.gogu.plist",
    "~/Library/Saved Application State/com.abaicus.gogu.savedState",
  ]

  caveats <<~EOS
    Gogu watches Claude Code sessions by installing hooks into
    ~/.claude/settings.json on first launch. It appends its own entries,
    leaves the rest of your config alone, and the tray menu removes them.

    The build is not notarized by Apple. This cask has already cleared the
    quarantine flag for you, so it will just open.
  EOS
end
