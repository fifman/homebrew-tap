require 'formula'

class Springbootx < Formula
  homepage 'https://spring.io/projects/spring-boot'
  url 'https://github.com/fifman/spring-boot/releases/download/2.2.0.BUILD-SNAPSHOT/spring-boot-cli-2.2.0.BUILD-SNAPSHOT-bin.tar.gz'
  version '2.2.0.BUILD-SNAPSHOT'
  sha256 '9903be949a85eb4264dd6dae3eb5147c0b6201d981dee1f1e09f0785fc039956'
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
    lib.install Dir["#{root}/lib/spring-boot-cli-*.jar"]
    bash_completion.install Dir["#{root}/shell-completion/bash/spring"]
    zsh_completion.install Dir["#{root}/shell-completion/zsh/_spring"]
  end
end
