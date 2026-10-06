cask "desktop-plus" do
  arch arm: "arm64", intel: "x64"

  version "3.6.7.1"
  sha256 arm:   "63a5442195a6eb75e9f3aa90447225a94abb33cd454c1b0130410b26ab4323f5",
         intel: "9a8d996e6d31ca380053f3e87f15d3337ca6d21e4442310d310a73b592b02805"

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
