cask "desktop-plus" do
  arch arm: "arm64", intel: "x64"

  version "3.6.4.0"
  sha256 arm:   "51806040ba4171861f692666fbceccaecbad41941f4baa0c6a0ed804e8c95e53",
         intel: "27522a3ea328646f839e5880e7320da61d6fb5f0551c1911bbc7faca28d993dc"

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
