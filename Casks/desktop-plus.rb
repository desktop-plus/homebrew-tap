cask "desktop-plus" do
  arch arm: "arm64", intel: "x64"

  version "3.6.8.0"
  sha256 arm:   "e82e7e0210bf9251d56c2fa965a919b91158490c4a78e60c55109bb471365026",
         intel: "5f62026233c51568160f3b1d70b2705a7862f0c5b7987d5e205f4e98da9d963f"

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
