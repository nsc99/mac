# local-audio-yomichan with its audio collection: a Yomitan audio source at
# http://127.0.0.1:5051/?term={term}&reading={reading} while Anki is open.
# Upstream's port 5050 is taken by the lab-local VM's registry (~/repos/lab/local).
# The collection is not freely downloadable, so add it to the store once:
#   nix-store --add-fixed sha256 local-yomichan-audio-collection-2023-06-11-opus.tar.xz
{
  ankiAddons,
  runCommand,
  requireFile,
}:
let
  audio-collection =
    runCommand "local-yomichan-audio-collection"
      {
        outputHashMode = "recursive";
        outputHash = "sha256-NxbcXh2SDPfCd+ZHAWT5JdxRecNbT4Xpo0pxX5/DOfo=";
        src = requireFile {
          name = "local-yomichan-audio-collection-2023-06-11-opus.tar.xz";
          url = "https://learnjapanese.moe/shouimethod/#local-audio-easy";
          sha256 = "1xsxp8iggklv77rj972mqaa1i8f9hvr3ir0r2mwfqcdz4q120hr1";
        };
      }
      ''
        mkdir -p $out
        cd $out
        tar -xf "$src"
      '';
  addon = ankiAddons.local-audio-yomichan.overrideAttrs {
    postPatch = ''
      substituteInPlace consts.py --replace-fail 'PORT: Final = 5050' 'PORT: Final = 5051'
    '';
  };
in
(addon.withConfig { userFiles = "${audio-collection}/user_files"; }).overrideAttrs (old: {
  # The add-on builds entries.db at build time with WO_ANKI=1, which on darwin
  # ignores the XDG_DATA_HOME nixpkgs sets and uses this path instead.
  buildCommand = ''
    export HOME=$(mktemp -d)
    mkdir -p "$HOME/Library/Application Support"
    ln -s $out/share/anki/addons/local-audio-yomichan/user_files \
      "$HOME/Library/Application Support/local-audio-yomichan"
  ''
  + old.buildCommand;
})
