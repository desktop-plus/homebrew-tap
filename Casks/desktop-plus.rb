cask "desktop-plus" do
  arch arm: "arm64", intel: "x64"

  version "3.6.2.0"
  sha256 arm:   "bd80fcfeb42fcc75cfbd8b80feb04e9bc53316c3f45e4ffbf554d3d0991b09ef",
         intel: "135c589a2787d6dcb0fd521a11c63f0977ab2c543b6f6e81b0b5f617af0f0a4a"

  url "https://github.com/desktop-plus/desktop-plus/releases/download/v#{version}/DesktopPlus-v#{version}-macOS-#{arch}.zip"
  name "Desktop Plus"
  desc "GitHub Desktop fork with extra features and improvements"
  homepage "https://desktop-plus.org/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Desktop Plus.app"
  binary "#{appdir}/Desktop Plus.app/Contents/Resources/app/static/desktop-plus-cli.sh",
         target: "desktop-plus-cli"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Desktop Plus.app"]
  end

  zap trash: [
    "~/Library/Application Support/Desktop Plus",
    "~/Library/Logs/Desktop Plus",
  ]
end
