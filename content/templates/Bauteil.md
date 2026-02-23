<%*
// 1) Bauteilname abfragen + umbenennen
let bauteil = await tp.system.prompt("Name des Bauteils");
if (!bauteil || !bauteil.trim()) {
  new Notice("Kein Name eingegeben – Datei wird nicht umbenannt.");
} else {
  bauteil = bauteil.trim().replace(/[\\\/:\*\?"<>\|]/g, "");
  await tp.file.rename(bauteil);
}

// Aktuellen Dateiinhalt lesen (um vorhandene Sektionen nicht zu überschreiben)
const content = await tp.file.content ?? "";
const hasKonstanten = content.includes("\n# Konstanten\n");
const hasVariablen  = content.includes("\n# Variablen\n");

// Gemeinsames Setup
const folder = "Lerninhalte/Basisgrößen";
const pickBasis = tp.user.basisgroessen;

// 2) Bauteilbeschreibung (immer neu einfügen; wenn du auch hier "nur wenn nicht vorhanden" willst, sag Bescheid)
tR += `# Bauteilbeschreibung\n\n`;
const beschreibung = await tp.system.prompt("Kurzer Erklärungstext zum Bauteil");
if (beschreibung && beschreibung.trim()) tR += `${beschreibung.trim()}\n\n`;

// 3) Konstanten sammeln (nur wenn Sektion nicht existiert)
let konstZeilen = [];
if (!hasKonstanten) {
  while (true) {
    const d = await pickBasis(tp, app, folder);
    if (!d) break;

    const wert = await tp.system.prompt(`Wert für ${d.basis} (LaTeX, ohne $)`);
    if (!wert || !wert.trim()) continue;

    const symbolLatex = await tp.system.prompt("Variablenname (LaTeX)", d.symbol);
    const unitLatex   = await tp.system.prompt("Einheit (LaTeX)", d.si_unit);

    const varCell  = `$${(symbolLatex ?? "").trim()}$`;
    const wertCell = `$${wert.trim()}\\,\\mathrm{${(unitLatex ?? "").trim()}}$`;

    konstZeilen.push(`| ${d.basis} ${varCell} | ${wertCell} |`);
  }
}

// 4) Variablen sammeln (nur wenn Sektion nicht existiert)
let varLines = [];
if (!hasVariablen) {
  while (true) {
    const d = await pickBasis(tp, app, folder);
    if (!d) break;

    const symbolLatex = await tp.system.prompt("Variablenname (LaTeX)", d.symbol);

    varLines.push(`- ${d.basis}: $${(symbolLatex ?? "").trim()}$`);
  }
}

// 5) Sektionen nur schreiben, wenn es Einträge gibt
if (!hasKonstanten && konstZeilen.length > 0) {
  tR += `# Konstanten\n\n`;
  tR += `| Variable | Wert |\n|---|---|\n`;
  tR += konstZeilen.join("\n") + "\n\n";
}

if (!hasVariablen && varLines.length > 0) {
  tR += `# Variablen\n\n`;
  tR += varLines.join("\n") + "\n\n";
}
%>
