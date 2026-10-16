# Changelog

Full release notes, with links to the docs for each feature: https://docs.subcloak.com/cloak-proxy/reference/release-notes/

## 0.3.0 (October 2026)

### New
- **Doctor: why isn't my traffic showing?** Tools › Doctor… explains per app or device what is stopping its requests (an app that skips the proxy, certificate pinning, an untrusted certificate, HTTP/3, the macOS proxy off or changed, a VPN, paused recording, filters, muting) with the evidence and one fix. Its Connections view logs every connection's DNS, connect and TLS times and why it failed. New MCP tool `diagnose_capture` (91 tools).
- **Split View**: two traffic panes side by side (View › Split View, ⌥⌘\\), each with its own filters, sidebar selection, sort and selection.
- **Web companion**: pair Safari or Chrome on a phone, tablet or another computer and watch your Mac's traffic live, with no app to install (Settings › Companion).
- **In-app SDK**: add the CloakProxyKit Swift package to a debug build of your iOS or macOS app and its URLSession requests show up under the app's name, with no proxy settings or certificate.

### Improved
- Much faster with lots of traffic: incremental filtering, search and sidebar counts cut main-thread work by 60–90%, autosave writes only what changed, and the proxy listens in under a second while a 300,000-request session loads.
- The Settings window is wider so all its tabs fit.

## 0.2.3 (October 2026)

### New
- **A real body editor** for Breakpoint, Map Local, Mock Sets, Compose and the API client: a code view with line numbers, syntax colours, folding, find and replace and undo, or an editable JSON **Tree** (edit values and types, rename, add, duplicate, move and delete keys, filter, copy paths, JSONPath and jq). Format, Minify, Sort keys and Revert, with the line and column of any JSON error. Form bodies get a table, binary bodies a hex view.
- **Traffic by device and app**: requests from an iPhone or iPad that uses your Mac as its proxy are named by the app in their User-Agent, and a **Devices** group in the sidebar lists each device with its apps. Rename a device from its right-click menu.
- **Install on iPhone or iPad** on the certificate page serves the certificate as a configuration profile, so Safari offers to install it.

### Fixed
- **Decrypt all of this device's HTTPS…** now asks first, and if a device refuses the certificate three times in two minutes, decryption is turned off for it so its apps keep working.

## 0.2.2 (October 2026)

### New
- **Redesigned main window**: a denser traffic list with one monospaced URL column, real app icons, method and status pills and a status dot; compact filter tabs with search in the toolbar (⌘F); a status capsule showing where Cloak Proxy is listening; a sidebar with Favorites, Apps and Domains; and a bottom bar with Clear, Filter, Auto Select and an "n tools on" popover. The inspector can sit below the list or beside it.
- **Inspector**: a summary bar with method and status pills, compact tabs, and a code view with line numbers, syntax colours, folding and find (⌘F) for Raw and Pretty bodies.
- **Columns for any request or response header**, and **traffic tabs** (⌘T), each with its own filters, sidebar selection and sort.
- **Import Charles settings**: Tools › Import Rules… reads a Charles settings export (or its preferences file) and shows what maps before anything is added.
- **Decode Protobuf and gRPC with your own .proto files**, in the proxy and the API client.
- **fetch() in scripts**: `onRequest` and `onResponse` can be async and call other APIs.
- **Captured traffic is kept when Cloak Proxy quits**, on by default for new installs. Large request and response bodies are kept on disk, and a session can hold up to 500,000 requests.
- **Help menu** with links to the docs, and **?** buttons that open the docs for the window you're in.
- **Check for Updates…**, plus an optional daily check (off by default) that only asks download.subcloak.com for the latest version number.
- A new install window in the DMG.

### Fixed
- Adding or editing rules through the control API or MCP failed when a Mock Set existed.
- Line numbers in the code view could overlap the text after scrolling to the top.

## 0.2.1 (October 2026)

### New
- **Search every request and response**: URLs, headers and decoded (gzip, deflate, Brotli) bodies, case-insensitive, about 15 ms across 30,000 requests. A **Found In** column shows where each match was, and the filter bar shows how many matched.
- **Trace Value** (⇧⌘T): the response a value (an ID, token or email) first came from, every endpoint that sent it afterwards and exactly where (path, query parameter, header, cookie, JSON key or form field), responses that returned it again, a flow map and a Markdown report.
- **Make Replayable Flow**: captured requests become an API-client flow. Values a later request reuses from an earlier response are read from the fresh response when it runs, and cookies come from the run's cookie jar.
- **Privacy Map** (⌥⌘P): for one app, every outside company it talks to and what each receives (email, phone, name, location, advertising, device and user IDs, the app's own auth tokens, IDs from its backend), and where in the request.
- **Apps that skip the proxy**: Flutter and React Native apps' domains are found, domains the app is connected to directly are listed first, apps with brief direct connections are detected, and captured apps that still connect directly are flagged.
- **MCP server**: 90 tools, including `search_requests`, `trace_value`, `build_replay_flow` and `privacy_map`.

### Fixed
- A request's own Cookie header is now merged with the API client's cookie jar instead of replacing it.
- Path placeholders after a version segment are `{id}` (for example `/v21.0/{id}`), in Trace Value and OpenAPI export.

## 0.2.0 (October 2026)

### New
- **Rewrite**, the twelfth debugging tool: set, add or remove headers and query parameters, change the status, and find and replace in URLs and bodies, without code.
- **Rules for chosen apps**: any rule can be limited to the apps you list.
- **Repeat Advanced**: send a request up to 10,000 times, up to 100 at once, with status counts and timing (min, average, p95, max).
- **Break on Next Request**: a one-shot breakpoint for the next matching request.
- **Mute an app**: proxy it without recording its traffic.
- **Keep captured traffic when Cloak Proxy quits** (off by default).
- **Highlights and comments** are saved in session and HAR files.
- **Generate Types** from JSON in TypeScript, Swift, Python, Go and Kotlin.
- **New snippet formats**: k6 load test, Python httpx and Playwright API test.
- **cloakctl**: `flow`, `monitor`, `sdk` and `mcp-server` commands.
- **MCP server**: 86 tools, including `repeat_request_many`, `generate_types`, `break_on_next` and `mute_app`.

### Fixed
- The SOCKS5 port checks the allowed-devices list like the main port.
- Passwords are masked in settings returned by the control API and MCP.
- Workspace folders with a `.gitignore` get `.cloak/` added to it.
- wget snippets no longer turn off certificate checks.
- Scripting keeps repeated query parameters and headers.
- Request numbers continue after the proxy restarts.
- Clearing API client history stays cleared.

## 0.1.0 (October 2026)

First public release.
