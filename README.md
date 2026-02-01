# LaTeX DevContainer for arXiv Submissions

A ready-to-use LaTeX environment optimized for writing academic papers compatible with arXiv.

## Quick Start

### Prerequisites
- [VS Code](https://code.visualstudio.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- Extension: [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Setup
1. Copy this folder to your project
2. Open in VS Code
3. `F1` → **Dev Containers: Reopen in Container**
4. Wait for the image to build (~3-5 min first time)

## Project Structure

```
project/
├── .devcontainer/
│   ├── devcontainer.json   # VS Code configuration
│   └── Dockerfile          # Docker image definition
├── main.tex                # Main article file
├── arxiv.sty               # arXiv preprint style (NeurIPS-based)
├── references.bib          # Bibliography
├── figures/                # Figures directory (create as needed)
├── Makefile                # Build automation
├── .gitignore
└── README.md
```

## Compilation

### VS Code
- **Auto-compile**: Save file (`Ctrl+S`)
- **Manual**: `Ctrl+Alt+B` or click ▶️

### Command Line
```bash
make            # Full compilation (pdflatex + bibtex)
make quick      # Quick compile (no bibliography)
make clean      # Remove auxiliary files
```

## arXiv Submission

### Create submission package
```bash
make arxiv
```

This creates `arxiv-submission.zip` containing:
- `main.tex` - Your source file
- `main.bbl` - Compiled bibliography (required by arXiv)
- `figures/` - All figures

### arXiv Requirements
- ✅ Uses pdfLaTeX (required)
- ✅ Type 1 fonts via `fontenc` + `cm-super`
- ✅ Traditional BibTeX (not biblatex)
- ✅ Includes `.bbl` file in submission

### Pre-submission Checklist
1. Remove `todonotes` or use `[disable]` option
2. Check `make check` for remaining TODOs
3. Verify all figures are in `figures/` folder
4. Test compilation from scratch: `make distclean && make`
5. Run `make arxiv` and verify package contents

## arxiv.sty

The included `arxiv.sty` is based on [kourgeorge/arxiv-style](https://github.com/kourgeorge/arxiv-style). It provides:
- NeurIPS-like aesthetic (single column, clean layout)
- Header with short title via `\shorttitle{...}`
- Professional typography with Times/Helvetica fonts

**Usage:**
```latex
\documentclass[11pt]{article}
\usepackage{arxiv}

\title{Full Title of Your Paper}
\shorttitle{Short Title}  % appears in header
```

## Included Packages

| Category | Packages |
|----------|----------|
| Typography | microtype, titlesec, xcolor |
| Math | amsmath, amssymb, mathtools |
| Figures | graphicx, float, caption, subcaption |
| Tables | booktabs |
| References | cleveref, hyperref, natbib |
| Fonts | T1 fontenc, cm-super (Type 1) |

## VS Code Extensions

- **LaTeX Workshop** - Compilation, preview, synctex
- **LTeX** - Grammar/spell checker
- **Code Spell Checker** - Additional spell checking

## Useful Commands

| Action | Shortcut |
|--------|----------|
| Compile | `Ctrl+Alt+B` |
| View PDF | `Ctrl+Alt+V` |
| Synctex (tex→pdf) | `Ctrl+Alt+J` |
| Clean files | `Ctrl+Alt+C` |
| Word count | `make count` |

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Bibliography empty | Run `make` (full compile) or compile twice |
| Undefined references | Compile again after bibtex |
| Font warnings | Ensure `cm-super` is installed |
| arXiv rejection | Check for biblatex usage (use natbib instead) |

## License

This template is free to use and modify.
