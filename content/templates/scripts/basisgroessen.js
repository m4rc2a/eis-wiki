module.exports = async (tp, app, folder = "Lerninhalte/Basisgrößen") => {
  const files = app.vault.getMarkdownFiles()
    .filter(f => f.path.startsWith(folder + "/"));

  if (!files.length) {
    new Notice(`Keine Größen in ${folder} gefunden.`);
    return null;
  }

  const labels = files.map(f => f.basename);
  const picked = await tp.system.suggester(["Fertig", ...labels], [null, ...files]);
  if (!picked) return null;

  const cache = app.metadataCache.getFileCache(picked);
  const fm = cache?.frontmatter ?? {};

  return {
    file: picked,
    basis: fm.basis ?? picked.basename,
    symbol: fm.symbol ?? "",
    si_unit: fm.si_unit ?? ""
  };
};
