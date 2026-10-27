_final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (_pyFinal: pyPrev: {
      pyqt6 = pyPrev.pyqt6.overridePythonAttrs (old: {
        # moc cannot follow the Darwin forwarding headers' include_next, so it
        # misses QT_VERSION and omits QRangeModel's Python wrapper metaobjects.
        postPatch =
          (old.postPatch or "")
          + prev.lib.optionalString prev.stdenv.hostPlatform.isDarwin ''
            cat >> pyproject.toml <<'EOF'
            [tool.sip.builder]
            qmake-settings = ["INCLUDEPATH = ${prev.qt6.qtbase}/lib/QtCore.framework/Headers $$INCLUDEPATH"]
            EOF
          '';
      });

      # Temporary: helper's own metadata says 0.1.1, derivation uses Anki's version
      anki-mac-helper = pyPrev.anki-mac-helper.overridePythonAttrs {
        dontCheckPythonMetadata = true;
      };
    })
  ];
}
