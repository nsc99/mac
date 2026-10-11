# Minimal Anki.app bundle that execs the home-manager anki wrapper,
# so Spotlight/Dock launches pick up the configured profile and addons.
{
  runCommandCC,
  anki,
  config,
}:
runCommandCC "anki-app" { } ''
  app=$out/Applications/Anki.app/Contents
  mkdir -p $app/MacOS

  cat > $app/Info.plist <<'EOF'
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0"><dict>
      <key>CFBundleName</key><string>Anki</string>
      <key>CFBundleIdentifier</key><string>io.schweigert.anki-launcher</string>
      <key>CFBundleExecutable</key><string>anki</string>
      <key>CFBundlePackageType</key><string>APPL</string>
      <key>CFBundleIconFile</key><string>anki.icns</string>
  </dict></plist>
  EOF

  cat > launcher.c <<'EOF'
  #include <unistd.h>
  int main(int argc, char **argv) {
      argv[0] = "anki";
      execv("${config.home.profileDirectory}/bin/anki", argv);
      return 127;
  }
  EOF
  mkdir -p $app/Resources
  cp ${anki.src}/qt/installer/app/resources/anki.icns $app/Resources/anki.icns
  $CC -O2 -o $app/MacOS/anki launcher.c
''
