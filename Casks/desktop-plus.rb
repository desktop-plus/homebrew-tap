cask "desktop-plus" do
  arch arm: "arm64", intel: "x64"

  version "3.6.4.1"
  sha256 arm:   "a16e484e1a9841595d6bda2979a41d023b48f7b51f6e2cb943d1886e59a08811",
         intel: "d05046c4edddfce0f9048b9b881aa43df712770f300888f1936d3a75950ad922"

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
