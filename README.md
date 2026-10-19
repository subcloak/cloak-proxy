<p align="center"><img src="https://subcloak.com/apps/cloak-proxy/icon.webp" width="96" height="96" alt=""></p>

<h1 align="center">Cloak Proxy</h1>

<p align="center">See every request your Mac makes. A free, native macOS debugging proxy with an API client built in.</p>

<p align="center">
  <a href="https://subcloak.com/apps/cloak-proxy?utm_source=github">Download</a> ·
  <a href="https://docs.subcloak.com/cloak-proxy/">Docs</a> ·
  <a href="https://docs.subcloak.com/cloak-proxy/reference/release-notes/">Release notes</a> ·
  <a href="https://github.com/subcloak/cloak-proxy/issues">Report a bug</a>
</p>

Cloak Proxy decrypts HTTPS, lets you pause, mock and rewrite any request, catches apps that ignore the system proxy, and lets Claude or any MCP client drive it.

- **Free for life.** No trial, no paid tier, no account, no sign-up.
- **Native and universal.** Swift, for Apple silicon and Intel, macOS 14 Sonoma or later.
- **Local only.** No telemetry. Traffic, collections and the root certificate's key stay on your Mac.

## What it does

| | |
|---|---|
| **Capture** | HTTPS decryption by host or app, traffic grouped by app with icons, HTTP/2, WebSocket, gRPC and GraphQL, and DNS capture for apps that skip the proxy |
| **12 debugging tools** | Breakpoints, Map Local, Map Remote, Rewrite (no code), Scripting, Block List, Allow List, Network Conditions, DNS Spoofing, No Caching, Mock Sets and Alerts. Any rule can be limited to chosen apps |
| **Devices** | One-click iOS Simulator and Android setup, and a certificate page with a QR code for iPhone, iPad and other devices |
| **API client** | Collections, environments, tests, flows and monitors, stored as plain files you can keep in Git |
| **Inspect** | JSON tree, jq and JSONPath, Protobuf, request diffs, copy as cURL or 21 other languages, types from JSON |
| **Share** | HAR, Charles sessions, CSV, Postman collections and OpenAPI, with secret redaction |
| **Automate** | An MCP server with 131 tools, and `cloakctl` for headless runs in CI |

## Install

1. Download `Cloak-Proxy.dmg` from [subcloak.com/apps/cloak-proxy](https://subcloak.com/apps/cloak-proxy?utm_source=github) or from [Releases](https://github.com/subcloak/cloak-proxy/releases).
2. Optional: check the file with `shasum -a 256 ~/Downloads/Cloak-Proxy.dmg` and compare it with the SHA-256 on the download page or in the release notes.
3. Drag Cloak Proxy into Applications and open it. It's signed with a Developer ID and notarized by Apple, so it opens like any other app.

Step by step, with screenshots: [Install Cloak Proxy](https://docs.subcloak.com/cloak-proxy/getting-started/install/).

Or with Homebrew: `brew install --cask subcloak/tap/cloak-proxy`.

**Linux (beta):** a `.deb` for Debian and Ubuntu, an RPM for Fedora and RHEL 10, or an AppImage or portable `.tar.gz` for any distribution with WebKitGTK 6.0, on x86_64 and ARM64, from the same download page or [Releases](https://github.com/subcloak/cloak-proxy/releases). See [Install on Linux](https://docs.subcloak.com/cloak-proxy/getting-started/install-linux/).

## This repository

Cloak Proxy's source isn't public. This repository holds the issue tracker, release downloads and the changelog.

- **Bugs and feature requests:** [open an issue](https://github.com/subcloak/cloak-proxy/issues/new/choose). Please remove tokens, cookies and private hostnames from anything you paste.
- **Security issues:** don't open a public issue. See [SECURITY.md](SECURITY.md).
- **Questions:** the [docs](https://docs.subcloak.com/cloak-proxy/) cover every feature, and the [FAQ](https://docs.subcloak.com/cloak-proxy/reference/faq/) answers the common ones.

Built by [Subcloak](https://subcloak.com/?utm_source=github), an independent security practice for teams that ship.
