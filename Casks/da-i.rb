cask "da-i" do
  version "3.1"
  sha256 "e1504467c19cef5d6753e6023a5b7e2007062973126176017cb11e130b6375c1"

  url "https://github.com/abaicus/da-i/releases/download/v#{version}/Da-i-#{version}.dmg"
  name "Dă-i"
  desc "Menu-bar utility for faster Space switching, Smart Zoom, keep-awake and input lock"
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
    Dă-i needs Accessibility permission for Space Switching, Smart Zoom and Input Lock:
    System Settings → Privacy & Security → Accessibility.

    The build is ad-hoc signed, so macOS ties that permission to the exact
    binary. After every upgrade, remove Dă-i from the Accessibility list and
    add it again.
  EOS
end
