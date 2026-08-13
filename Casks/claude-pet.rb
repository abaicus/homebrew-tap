cask "claude-pet" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "6631158d5e676b47802a1284b26b5aee6e8e5be131bcb1e9061f94c558fb377a",
         intel: "35cc740a5e41b5dae7cdcfdfd73400115af72aea4dfb0b2512336f426e9224c9"

  url "https://github.com/abaicus/claude-pet/releases/download/v#{version}/claude-pet-#{version}-#{arch}.zip"
  name "Claude Pet"
  desc "Desktop tamagotchi that feeds on Claude Code activity"
  homepage "https://github.com/abaicus/claude-pet"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :catalina

  app "Claude Pet.app"

  # Not signed with an Apple Developer ID, so Gatekeeper would quarantine it
  # into "damaged, move to Trash". The build IS ad-hoc signed and its checksum
  # is pinned above; this drops the quarantine flag on that verified download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Claude Pet.app"]
  end

  uninstall quit: "com.abaicus.claude-pet"

  # Not listed: ~/.claude/settings.json. The pet writes its hooks there and
  # removes exactly its own entries from the tray's uninstall — a zap that
  # rewrote your Claude config would be overreach.
  zap trash: [
    "~/.claude-pet",
    "~/Library/Application Support/Claude Pet",
    "~/Library/Preferences/com.abaicus.claude-pet.plist",
    "~/Library/Saved Application State/com.abaicus.claude-pet.savedState",
  ]

  caveats <<~EOS
    Claude Pet watches Claude Code sessions by installing hooks into
    ~/.claude/settings.json on first launch. It appends its own entries,
    leaves the rest of your config alone, and the tray menu removes them.

    The build is not notarized by Apple. This cask has already cleared the
    quarantine flag for you, so it will just open.
  EOS
end
