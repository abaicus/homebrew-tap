cask "da-i" do
  version "3.0"
  sha256 "920876b0fa25d99e6a260fc84f59564d8f0affef55bdd702a993160266929f40"

  url "https://github.com/abaicus/da-i/releases/download/v#{version}/Da-i-#{version}.dmg"
  name "Dă-i"
  desc "Menu-bar utility for faster Space switching, Smart Zoom and keep-awake"
  homepage "https://github.com/abaicus/da-i"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Dă-i.app"

  # Ad-hoc signed, not notarized: Gatekeeper would block the quarantined app.
  # The checksum is pinned above; this drops the flag on that verified download.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Dă-i.app"]
  end

  uninstall quit: "local.da-i.app"

  zap trash: "~/Library/Preferences/local.da-i.app.plist"

  caveats <<~EOS
    Dă-i needs Accessibility permission for Space Switching and Smart Zoom:
    System Settings → Privacy & Security → Accessibility.

    The build is ad-hoc signed, so macOS ties that permission to the exact
    binary. After every upgrade, remove Dă-i from the Accessibility list and
    add it again.
  EOS
end
