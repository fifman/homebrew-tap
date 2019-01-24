class Surlane < Formula
  desc "secure tunnel like shadowsocks, but lightweight"
  homepage ""
  url "https://github.com/fifman/surlane/releases/download/v0.4.1/surlane_0.4.1_Darwin_x86_64.tar.gz"
  version "0.4.1"
  sha256 "d70f8f924a2a44b6f0630e10c801708e196e15a89a482c4eda8fec21b116d81d"

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
