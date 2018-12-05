class Surlane < Formula
  desc "secure tunnel like shadowsocks, but lightweight"
  homepage ""
  url "https://github.com/fifman/surlane/releases/download/v0.3.0/surlane_0.3.0_Darwin_x86_64.tar.gz"
  version "0.3.0"
  sha256 "2b5a7c4e5dded6a3060e915a8037a09eea3e0856c3342f1dfc87f323196ba8b5"

  def install
    bin.install "surlane"
    (etc/"surlane").install "config.toml"
  end

  def caveats; <<~EOS
    config file is stored in #{etc}/surlane/config.toml
  EOS
  end

  plist_options :startup => false

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>ProgramArguments</key>
    <array>
        <string>#{opt_bin}/surlane</string>
        <string>-c=#{etc}/surlane/config.toml</string>
    </array>
    <key>KeepAlive</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>#{var}/log/surlane.log</string>
    <key>StandardOutPath</key>
    <string>#{var}/log/surlane.log</string>
</dict>
</plist>

  EOS
  end

  test do
    system "#{bin}/surlane --version"
  end
end
