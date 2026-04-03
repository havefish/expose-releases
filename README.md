# Expose ⚡️
### Instant, Secure local Tunnels for Modern Developers.
[![License](https://img.shields.io/badge/license-Proprietary-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-0.0.6-purple.svg)](https://github.com/havefish/expose-releases/releases)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)](#quick-install)

Expose is a high-performance tunneling service designed to help you securely share your local development environment with the world. Built as a **standalone, zero-dependency binary**, it eliminates the friction of traditional tunneling tools.

---

## 🚀 Quick Install

Get up and running in seconds with our official installers.

### macOS & Linux
```bash
curl -sL https://expose.host/install.sh | bash
```

### Windows (PowerShell)
```powershell
iwr -useb https://expose.host/install.ps1 | iex
```

---

## 🤔 Why Expose?

Expose is designed for developers who want a **professional, private, and frictionless** way to demo apps and test webhooks without the baggage of personal account management.

- **Zero Auth**: No signups, no dashboards, no tracking cookies. We literally don't want your data.
- **Sticky Subdomains**: Expose uses machine-fingerprinting to ensure you get the same public URL every time you connect.
- **Edge Filtering**: A built-in firewall at our relay. Block or allow specific paths (like `/admin/*`) before they even reach your machine.
- **Single Binary**: No dependencies to install. Just a fast, minimalist Go-powered binary.

---

## 🔒 Privacy & Trust

While Expose is proprietary software, it is **Private by Design**. Our relay server acts as a clean conduit—we do not log your request bodies, and because there are no accounts, we have no user data to store or sell.

---

## 📖 Documentation & Support

Full documentation, including advanced configuration and protocol details, can be found at **[expose.host](https://expose.host)**.

- **Bugs & Features**: Please use the [GitHub Issues](https://github.com/havefish/expose-releases/issues) page to report problems.
- **Releases**: All official binary releases are managed in this repository.

---

## 📄 License & Copyright

Copyright © 2026 **Chinmaya Panda**. All rights reserved.

Expose is proprietary software. This repository contains the official distribution logic and installation scripts. Use of the Expose binary is subject to the terms in the [LICENSE](LICENSE) file.
