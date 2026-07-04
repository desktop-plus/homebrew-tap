cask "desktop-plus" do
  arch arm: "arm64", intel: "x64"

  version "3.6.2.1"
  sha256 arm:   "3619b3108946a62789e619190b6552ea45b338413c9a6f35e1ab9f447e6a9a95",
         intel: "baa7ba0c15a2e8bf9c3384ddad738ba3a407c6fae827da448b04ea5e9d13ed81"

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
