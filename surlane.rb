class Surlane < Formula
  desc "secure tunnel like shadowsocks, but lightweight"
  homepage ""
  url "https://github.com/fifman/surlane/releases/download/v0.2.0/surlane_0.2.0_Darwin_x86_64.tar.gz"
  version "0.2.0"
  sha256 "485b5040b46fb9b030403d1f191480ad76e63c2b624a349fdfbe3fac52e89436"

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
