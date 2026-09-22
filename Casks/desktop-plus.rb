cask "desktop-plus" do
  arch arm: "arm64", intel: "x64"

  version "3.6.6.1"
  sha256 arm:   "ef32d290839416495039aaa3abcc2e11cc062698d09fbfae031bfeb2363bd928",
         intel: "e7d278fedd10c70bdff053b48afc9cdfdd2f8ccd9bcd2cf78af4bd62e0d48b11"

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
