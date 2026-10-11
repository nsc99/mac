_final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (_pyFinal: pyPrev: {
      # Temporary: helper's own metadata says 0.1.1, derivation uses Anki's version
      anki-mac-helper = pyPrev.anki-mac-helper.overridePythonAttrs {
        dontCheckPythonMetadata = true;
      };
    })
  ];
}
