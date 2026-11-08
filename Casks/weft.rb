cask "weft" do
  version "0.6.8"
  sha256 "e1fdf01be82bbf85fbbde146c8ad0c9f528b1ad6aaeac0df208bbc955e19b58d"

  url "https://github.com/ahuili/weft/releases/download/v#{version}/Weft-#{version}.zip"
  name "Weft"
  desc "Window workbench: per-display scenes, stage layouts and pinyin window switching"
  homepage "https://github.com/ahuili/weft"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Weft.app"

  # 还没有 Apple 公证：去掉隔离标记，否则 macOS 会拦着不让打开
  weft_app = "#{appdir}/Weft.app"
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", weft_app], must_succeed: false
  end

  uninstall quit: "local.weft.app"

  zap trash: [
    "~/Library/Application Support/Weft",
    "~/Library/Preferences/local.weft.app.plist",
  ]

  caveats <<~EOS
    Weft 需要「辅助功能」权限（必需）和「录屏」权限（只用来画窗口缩略图）。
    第一次打开会有引导；之后在 系统设置 › 隐私与安全性 里也能改。
  EOS
end
