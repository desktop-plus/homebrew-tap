cask "desktop-plus" do
  arch arm: "arm64", intel: "x64"

  version "3.6.6.0"
  sha256 arm:   "c74058ccfa8a504cc84e432dc72c6835871833f29e0f1da677d6d42de90f6440",
         intel: "39779762a3c4283ac5ff460e4d135a2b1d5d753a0b4138ad86def1645478fa04"

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

  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Desktop Plus.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/Desktop Plus",
    "~/Library/Logs/Desktop Plus",
  ]
end
