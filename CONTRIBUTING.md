# Contributing to Expose ⚡️

Thank you for your interest in helping improve **Expose**! While the core CLI and server source code are currently private, we love receiving contributions for the public-facing aspects of the project.

## 🎯 Scope of Contributions

You can contribute to anything in this repository, including:
- **Documentation**: Fixing typos, clarifying usage, or adding new examples to `web/index.html`.
- **Website UI/UX**: Improving the design, responsiveness, or animations of the landing page.
- **Installers**: Refining the `install.sh` and `install.ps1` scripts for better cross-platform compatibility.
- **Bug Reports**: Opening issues for technical problems you encounter while using the tool.

## 🛠 Local Development

To test changes to the website locally:

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/havefish/expose-releases.git
    cd expose-releases/web
    ```

2.  **Start a local server**:
    You can use any static file server. For example, using Python:
    ```bash
    python3 -m http.server 3000
    ```

3.  **Preview**:
    Open `http://localhost:3000` in your browser.

## 📬 How to Contribute

### 1. Reporting Bugs
- Search existing [Issues](https://github.com/havefish/expose-releases/issues) to see if the bug has already been reported.
- If not, open a new issue with a clear title and a description of how to reproduce the problem.

### 2. Suggesting Features
- We welcome feature requests! Open an issue describing the "Why" and "How" of your proposal.

### 3. Pull Requests (PRs)
- Fork the repository and create your branch from `main`.
- If you've added code that should be tested, please verify it locally.
- Ensure your PR description clearly describes the changes.

## ⚖️ Code of Conduct
Please be respectful and professional in all interactions. We aim to keep Expose a welcoming space for all developers.

---

*Note: If you are looking for the source code for the `expose` CLI or the backend server, please note that those components are currently not open-sourced. We use this repository specifically for distribution and public documentation.*
