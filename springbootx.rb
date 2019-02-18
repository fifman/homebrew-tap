require 'formula'

class Springbootx < Formula
  homepage 'https://spring.io/projects/spring-boot'
  url 'https://github.com/fifman/springcli/releases/download/1.0.0/springcli-1.0.0-bin.tar.gz'
  version '1.0.0'
  sha256 'ca2aa4a98d55e5a40fa590fc5dee60285cd13581128a0818a2c27c6cd4fb5cdb'
  head 'https://github.com/fifman/spring-boot.git'

  if build.head?
    depends_on 'maven' => :build
  end

  def install
    if build.head?
      Dir.chdir('spring-boot-projects/spring-boot-cli') { system 'mvn -U -DskipTests=true package' }
      root = 'spring-boot-projects/spring-boot-cli/target/spring-boot-cli-*-bin/spring-*'
    else
      root = '.'
    end

    bin.install Dir["#{root}/bin/spring"]
    lib.install Dir["#{root}/lib/springcli-*.jar"]
    bash_completion.install Dir["#{root}/shell-completion/bash/spring"]
    zsh_completion.install Dir["#{root}/shell-completion/zsh/_spring"]
  end
end
