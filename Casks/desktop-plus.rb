cask "desktop-plus" do
  arch arm: "arm64", intel: "x64"

  version "3.6.4.4"
  sha256 arm:   "0cb76893b5f23b568a0e242786fe338a58dee1be0b2e192f30ff4d91934160ad",
         intel: "62e24f08752bd962b46ebabcb5e48d619920eb417fc1791dc07dd7138cc58044"

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
