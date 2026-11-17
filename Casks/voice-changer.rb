cask "voice-changer" do
  version "1.0.0"
  sha256 "ae3075687a2cd7a615fffe21eb4a4b1d209b890464d676898b3cfe2db923b3ff"

  url "https://github.com/abaicus/voice-changer/releases/download/v#{version}/VoiceChanger.zip"
  name "Voice Changer"
  desc "Real-time voice changer that feeds a virtual microphone"
  homepage "https://abaic.us/voice-changer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on cask: "blackhole-2ch"
  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "VoiceChanger.app"

  # Not signed with an Apple Developer ID, so Gatekeeper would block it. The
  # checksum is pinned above; this drops the quarantine flag on that download.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/VoiceChanger.app"]
  end

  uninstall quit: "local.voicechanger.app"

  zap trash: [
    "~/Library/Application Support/VoiceChanger",
    "~/Library/Preferences/local.voicechanger.app.plist",
  ]

  caveats <<~EOS
    Voice Changer sends your changed voice to BlackHole 2ch, which this cask
    installs. In Discord, Zoom, Google Meet or OBS pick "BlackHole 2ch" as the
    microphone.

    The build is not notarized by Apple. This cask has already cleared the
    quarantine flag for you, so it will just open.
  EOS
end
