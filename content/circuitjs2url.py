import urllib.parse
import os

def replace_circuitjs_block_with_link(markdown_text):
    start = markdown_text.find('```circuitjs')
    if start == -1:
        return None  # Keine Änderung
    code_start = markdown_text.find('\n', start) + 1
    code_end = markdown_text.find('```', code_start)
    if code_end == -1:
        return None  # Keine Änderung
    circuitjs_data = markdown_text[code_start:code_end].strip()
    encoded = urllib.parse.quote(circuitjs_data)
    url = f"https://falstad.com/circuit/circuitjs.html?cct={encoded}"
    markdown_link = f"[Klick Hier für CicuitJS]({url})"
    before = markdown_text[:start]
    after = markdown_text[code_end + 3:]
    # Wiederholung für mehrere circuitjs-Blöcke (optional: solange ersetzt werden kann)
    replaced_text = f"{before}{markdown_link}{after}"
    # Test auf weitere Vorkommen
    while True:
        next_result = replace_circuitjs_block_with_link(replaced_text)
        if next_result is None:
            break
        replaced_text = next_result
    return replaced_text

def process_markdown_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as file:
        content = file.read()
    replaced = replace_circuitjs_block_with_link(content)
    if replaced and replaced != content:
        with open(filepath, 'w', encoding='utf-8') as file:
            file.write(replaced)
        print(f"Ersetzt – {filepath}")

def process_all_files(root_dir):
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file.endswith('.md'):
                path = os.path.join(root, file)
                process_markdown_file(path)

if __name__ == "__main__":
    import sys
    if len(sys.argv) != 2:
        print("Verwendung: python script.py <verzeichnis>")
        sys.exit(1)
    root_dir = sys.argv[1]
    if not os.path.isdir(root_dir):
        print(f"Verzeichnis '{root_dir}' existiert nicht!")
        sys.exit(2)
    process_all_files(root_dir)
