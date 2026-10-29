# Changelog

Full release notes, with links to the docs for each feature: https://docs.subcloak.com/cloak-proxy/reference/release-notes/

## 0.7.0 (October 2026)

Mac only: the Linux beta stays on 0.5.1. Cloak Proxy 0.7.0 for the Mac adds **Team Cloud**, a paid plan for teams: shared workspaces, rule sets and mock sets, a secrets vault with per-person access, reviews, a team session library, CI access and live pair debugging, end-to-end encrypted, with a web console for billing, members, SSO, SCIM, policies and a 1-year audit log. Cloak Proxy itself stays free for life, with no account, and Personal Cloud is unchanged. Update with **Check for Updates…**.

### New

- **Team Cloud.** $5 a seat a month, or $48 a seat a year ($4 a month), 2 seats minimum, plus tax. Founding offer: 30% off the first year for the first 20 teams of 10 or more seats (they keep at least 10 seats and the same plan for that year). Buy it in the console at console.subcloak.com; owners and billing managers don't need a seat. A full refund of any team payment within 30 days, on request. A Team seat doesn't include Personal Cloud.
- **End-to-end encrypted, with the keys on members' Macs**, the CI tokens admins create and a printed **Team Recovery Kit**. Subcloak can't read your team's data (unless automatic approval after SSO is on, which trusts your identity provider and our server to admit Macs), except what you publish to monitors and hosted mocks (marked \*). The team's members, roles and Macs are a signed list that every Mac checks, and a person's first Mac joins only after they and an admin compare a 6-digit code, and their further Macs after they compare one with a Mac of their own (or automatically after SSO, if an admin turns that on).
- **Spaces**: team workspaces with live updates, shared rule sets and mock sets (fill one with **Add From This Mac…**, and switch each one on per Mac in **Rules › Team Sets**; a rule or mock set applies once a manager of the set has approved its content, in **Held Items…**), a session library, Findings and shared agent setups. Spaces are open to the team or restricted to the people you choose; roles are Viewer, Editor and Manager. **Move to a Restricted Space…** copies an open space into a new restricted one.
- **Team vault**: folders of secrets that only listed people can open, used in requests as `{{vault:team/NAME}}` and filled in on your Mac when a request is sent, only to the hosts set on each item. Reveal and Copy need Touch ID or your login password; Cloak Proxy's own MCP tools and AI assistants never get team vault values (a shared MCP server you install gets the values its approved version names, through `cloakctl mcp-exec`).
- **Protected sets and reviews**: editors propose, managers approve in the **Reviews** window, and every Mac checks the approval. Self-approval is refused.
- **Comments and @mentions** on any team item, with an **Activity** popover and email notifications that never contain comment text.
- **Team Findings and Report Bug to the team**, with assignees.
- **CI**: tokens made in **Settings › Team › CI** let `cloakctl run --team-mocks … --team-rules … --upload --library …` apply team sets in a CI job and upload the recording to the library. `cloakctl team pull`, `team whoami` and `team audit verify`.
- **Live pair debugging**: share your live capture with up to 10 teammates in a read-only window, end-to-end encrypted through Subcloak's relay.
- **Monitors\*** with Slack, PagerDuty, Opsgenie, webhook and email alerts, and **hosted mocks\*** at an unguessable public URL. Both run on Subcloak's servers and are not end-to-end encrypted: the app says so before you publish, and each secret you include needs its own tick.
- **Shared MCP servers and agent setups**: install for Claude Code or Codex; secrets are vault references that `cloakctl mcp-exec` fills in for each person when the server starts; a server a teammate changes doesn't start until you approve the change, and a literal secret is refused.
- **Admin policies**, each labelled with who enforces it: Subcloak's server or Cloak Proxy on each Mac.
- **A 1-year audit log**, metadata only, chained and checked by admins' Macs, with JSONL and CSV export. **90-day version history** and **Recently Deleted** for every team item.
- **SSO** with OIDC (Okta, Microsoft Entra ID, Google Workspace and other OIDC providers; SAML coming later) and **SCIM** for Okta and Entra ID, at no extra charge. SSO never gives a Mac the team's keys unless an admin turns on automatic approval after SSO (off by default).
- **Support**: a first reply within 1 business day at team-support@subcloak.com (**Help › Contact Team Support**), and a 30-minute onboarding call for yearly teams of 10 or more seats.
- **A new managed preference, `CloudPersonalDisabled`**, turns off Personal Cloud but leaves Team Cloud on. `CloudDisabled` turns off both.

### Changed

- When Send follows a redirect to another origin (another host, port or scheme, such as https to http), it sends only standard headers there (Accept, Accept-Language, Accept-Encoding, User-Agent, Content-Type, Cache-Control, Pragma). Authorization, cookies, API-key headers and your custom headers stay with the host you sent them to.
- A URL whose port isn't between 1 and 65535 is refused, wherever it comes from (a request, a redirect, a Map Remote or Rewrite rule).

### Fixed

- Everything in 0.6.1, which 0.7.0 includes.

### Known issues

- Team commands in the Linux `cloakctl` (for Linux CI runners) come in a later release; CI on macOS runners works now.
- An editor of a team set can reorder its approved items (not add, change or remove them) without a manager's approval. For rule types where the first match wins, that can change which approved rule applies. Target: 0.7.1. (R16B-I4)
- Each change of the team key adds to the members' inbox keyring rows, now bounded only by the size of a rotation. Target: 0.7.1. (R16B-I1)
- When a member's Mac changes the team key (after they remove a Mac of their own), the first copies of each space key saved for the new key win. A member can make those copies ones a newly added Mac can't open, or ones other Macs refuse. Macs that already had the keys are fine again once an admin's Mac next changes the team key; a Mac added in that window may stop syncing and need to be removed and added again. Target: 0.7.1. (R14B-M1)
- Each change of the team key makes every Mac that writes create new space keys, which count against the 15,000 a team can hold. A member can change the team key by adding and removing Macs of their own, up to 10 a day. Target: 0.7.1. (R14B-M2)

## 0.6.1 (October 2026)

Mac only: the Linux beta stays on 0.5.1. Lighter on your Mac when left open for days, dozens of crash and correctness fixes, and your plan always in view.

### New
- **Your plan, upfront:** a **Free** or **Personal Cloud** pill next to the status capsule in the toolbar opens a Plans view: what's free, what Personal Cloud adds, its price and the founding offer while it lasts. **Cloak Proxy › Get Personal Cloud…** opens the same view, and so do `cloakproxy://cloud/get` links, which only show it. Nothing starts without a click.
- **"subcloak"** in the sidebar header opens subcloak.com.

### Faster
- **Light when left open:** autosave writes only what changed instead of rewriting the whole session file every 30 seconds; idle timers pause while no window is visible; the traffic table and sidebar no longer redo work for the whole session on every redraw. On a test Mac, idle CPU with the window visible went from about 3.8% to 0.4%.
- **Large responses:** when a response breakpoint, response script or body rewrite matches a response over 64 MB, the response now streams through unchanged and the request is tagged with the tool that was skipped, instead of being held in memory.

### Fixed
- **Crashes from crafted input:** huge, negative or not-a-number values in captured traffic, imported files, MCP tool arguments and the control API (limits, timeouts, ports, token counts, dates, protobuf durations, JSONPath steps, network conditions, Socket.IO and MQTT settings) can no longer crash the app. A damaged autosave no longer crashes every launch.
- **Hangs from crafted documents:** YAML alias bombs, self-referencing OpenAPI schemas and contract checks, GraphQL fragment fan-out, deeply nested JSONPath filters and self-multiplying `{{variables}}` are now bounded.
- **Wrong results:**
  - a POST body sent right after its headers is no longer lost with DNS capture, and neither is data sent right after a SOCKS5 CONNECT;
  - breakpoints check every matching rule, not just the first;
  - Rewrite keeps the query's encoding and updates the Host header when it changes the host;
  - backslashes in quoted query terms are kept;
  - copy as code no longer keeps `Content-Encoding: gzip` with a decoded body;
  - host rules, including SSL Proxying exclusions, also match a name with a trailing dot;
  - DNS Spoofing entries are trimmed;
  - "Include subpaths" stops at path boundaries (`/api` no longer matches `/apiv2`);
  - cURL for a HEAD request no longer adds a body that curl refuses;
  - Map Local strips its folder prefix the same way it matches;
  - JavaScript exports keep large integer IDs exact.
- **Collection runs:** `pm.execution.runRequest("Name")` finds a request by name or folder path in the collection being run, and a huge or invalid request delay no longer crashes the runner (`--delay-request` refuses it).
- **Autosave** is flushed to disk before it replaces the old file, a save cut short no longer leaves a hidden copy behind, and a failed save is retried.
- **API client workspaces:** a workspace folder that was moved, renamed or reached through a symlink, or a git branch checked out without the workspace, is now shown as unavailable instead of being replaced with the starter workspace. This applies in the app, `cloakctl` and AI assistants' workspace tools. Your secrets file is never overwritten, and Personal Cloud no longer syncs the gap as deletions. A reload that lands mid-move waits for the folder to settle instead of reading it as empty.
- **Toxiproxy API:** parallel edits all land.
- **MCP:** closing a stdio MCP server that stopped reading no longer hangs.
- **Personal Cloud:**
  - a stale change from a removed or stolen Mac no longer stops sync for everyone: it is ignored, that Mac is named in Sync issues, and anything that looks like the server rolling back still stops sync;
  - signing out and back in no longer stops sync;
  - **Put Back** on a Mac set up after another Mac was removed no longer deletes a record on your other Macs;
  - security hardening (an unreadable record from another Mac is held and named while the rest keeps syncing; approvals wait while a security question is open; Recovery Kit and join checks).
- **Settings › Certificate:** each state of the install button has its own title and tooltip, and buttons that can't do anything yet are off.
- **Polish:** the JSON tree's Value column takes the spare width, inspector tabs fit narrow panes, clearer JWT warnings, consistent Settings footers and empty states, Title Case buttons, and the AI consent sheets show the app icon.

## 0.6.0 (October 2026)

Mac only: the Linux beta stays on 0.5.1. Cloak Proxy is still free for life and never needs an account. This version adds Personal Cloud, an optional paid plan, and fixes crashes that crafted input could cause in 0.5.5.

### New
- **Personal Cloud (optional, paid):** sync your setup between your Macs and share captured requests as links, end-to-end encrypted: your Macs encrypt everything before it's uploaded, and the keys never leave them and your Recovery Kit. $3 a month or $25 a year; the first 50 yearly subscribers pay $20 for their first year. There's no free trial: buy it in **Settings › Cloud**, and get a full refund within 30 days, no questions asked. Payments go through Polar.
- **Sync between Macs:** rules, mock sets, API client workspaces and environments, scopes, saved queries, highlight rules and saved filters, on up to 5 Macs with 5 GB of storage. **Settings › Cloud › What syncs** chooses what goes up; workspaces from another Mac show as **Not on this Mac**, with **Add to This Mac…**, and **Sync This Workspace…** turns on sync from the API client.
- **Add a Mac by approving it** from one you already use, after comparing the codes both Macs show. A new Mac then offers **Restore this Mac** in one step, followed by a **Finish setting up** checklist: install this Mac's own certificate (it's never synced), turn on the proxy, and review anything that arrived switched off.
- **Recovery Kit:** a one-page PDF that gets everything you sync back on a new Mac, even if you lose every Mac. The kit signs a new Mac in by itself: no email code needed.
- **Changes from your other Macs that could run code, read files or change what's captured wait for you:** scripts, Map Local and similar rules, mock sets and workspace scripts arrive switched off, and a change to the active scope, to decryption and proxy settings, to a secret value or to the active environment is held. Settings › Cloud › Sync issues asks you to **Review changes** before they apply, naming the Mac each change came from. Until you approve a request another Mac changed, it's sent without your credentials, variables or cookies.
- **Security code:** a 12-digit code in Settings › Cloud › Devices. Compare it on your Macs to check they agree on which computers can read your data.
- **Share links:** select requests and choose **Share Link…**, or use **File › Share Session…** or **File › Share File…** for a saved `.har` or `.cloaksession`. Known secret formats are redacted by default (redaction covers common formats, not every one), **Hide all body values** hides every body, query, path and header value except a few headers that describe the message (Content-Type, Accept, Accept-Encoding, Accept-Language, User-Agent, Content-Encoding, Transfer-Encoding, Connection, Date) and keeps the method, host, header names, plain field names and the structure, and links can have a password, a view limit and an expiry of up to 30 days. The recipient opens the link in a browser, read-only, and can copy any request as cURL, fetch or Python. If the leak check finds something, or can't fully check a large body, Cloak Proxy asks before creating the link.
- **See who opened a link:** **File › Share Links…** lists each link's views, views left, when it was last opened and from which country, with **Revoke**. `cloakctl share` creates, lists and revokes links.
- **Delete your Cloud account** from Settings › Cloud › **Delete Account…**. The deletion always waits 72 hours, and the email we send has a link that cancels it, as does any of your Macs.
- **Buy and set up on your first Mac:** until your encryption key exists, only the computer you signed in on first can buy Personal Cloud and set it up, so someone who can read your email can't take setup over.
- The MCP server has 154 tools (`create_share_link`, `list_share_links`, `revoke_share_link`). An assistant's link always asks you first, is always redacted and lasts at most 7 days; `hide_body_values` does what **Hide all body values** does.

### Changed
- Live sharing on your network refuses queries that use `tag:`, `rule:`, extracted columns (`col.`) or `is:highlighted`, since highlight and extract rules can now change on another Mac.

### Fixed
- **Crafted traffic and files can no longer crash the app:** a request body with deeply nested GraphQL (`{"query":"{a{a{a…"}`) from any app or page crashed 0.5.5 while it named the operation. The same kind of crash is fixed for deeply nested YAML in imported specs and Insomnia exports, a Charles settings file nested very deep or with an out-of-range rewrite group number, an Insomnia folder that contains itself, a Postman example with a huge status code, negative status codes in session files, examples and rules, and a flow Repeat count past what the app can count.
- **A `CONNECT` to port 70000 or -1 can no longer crash the proxy** when an upstream SOCKS5 proxy is set. Ports outside 1 to 65535 are refused.
- **Copy as cURL is safe to paste:** a request with an unusual method, or with control or bidirectional characters in its URL, headers or body, could produce a command that ran something else when pasted into a terminal. Every copy format now quotes the method and escapes those characters, and Copy as Python writes `True`, `False` and `None` from JSON bodies.
- **`pm.sendRequest` and `pm.execution.runRequest` work again in scripts:** in the released app, a script that awaited either one never got its answer and failed with "a promise that never settles", and `pm.sendRequest(url, callback)` without `await` was never sent. Both now work, and the callback form runs before the script finishes.

## 0.5.5 (October 2026)

Mac only for now: the Linux beta (0.5.1) has the same crash, and its fix follows in the next Linux release.

### Fixed
- **Crafted JSON can no longer crash the app:** a response, file or message with a broken Unicode escape (as short as `{"a":"\ud800A"}`) crashed Cloak Proxy wherever it read JSON, including live capture analysis, the JSON viewer and inspectors, Generate Types, the API client, imports, AI replies, the MCP server and `cloakctl`. A broken escape now reads as the replacement character "�".
- **Out-of-range numbers can no longer crash it either:** a huge duration in an imported HAR or session file, a token count or `expires_in` from an AI or OAuth reply, or a stream timeline that goes backwards is clamped instead of crashing.

## 0.5.4 (October 2026)

Mac only: the Linux beta stays on 0.5.1.

### New
- **In-app updates:** Check for Updates… shows the release notes, and **Install and Relaunch** downloads the new version, checks that it's signed by Subcloak, and installs and reopens it. Homebrew installs are pointed to `brew upgrade --cask cloak-proxy`. This version is the first that updates itself; 0.5.3 and earlier update by hand.
- **Focus mode:** right-click apps or hosts and choose **Focus on These**, or use the toolbar's **Focus** button. Only those are recorded; everything else passes through untouched, neither decrypted nor listed. A banner shows what's in focus, and **Stop Focusing** is one click. `cloakctl focus`.
- **Mute a host or a whole domain**, next to Mute App, in one Muted apps and hosts list. `cloakctl mute host`.

### Improved
- **Stays light when left running:** Settings › General › Capture keeps the last 100,000 requests and a week of traffic by default (up to 500,000 requests, or no age limit). The oldest are trimmed in the background, never highlighted, commented or Findings requests. A kept session larger than 100,000 requests is trimmed once it loads, so save it to a file first if you need all of it. `cloakctl retention`.
- **No freezes under heavy traffic:** moving large bodies to disk no longer happens on the main thread.
- The MCP server has 151 tools (`set_focus`, `mute_host`, `set_retention`).

## 0.5.3 (October 2026)

Mac only: the Linux beta stays on 0.5.1.

### Fixed
- **Deleting in the API client no longer crashes:** deleting a collection, folder or request while its editor was open (for example a Make Tests collection showing its generated docs) crashed the app every time. Its tabs now close first; nothing was lost, because the delete hadn't been saved yet.
- **Wildcard highlight rules match:** a pattern such as `*.example.com`, `example.com/*` or `https://*.example.com/*` in a rule's Applies to or the query bar is a URL pattern, read the way Map Local reads it, and so is `url:` with a `*`. `host:example.com:8443` checks the port, and a pattern that can never match in `host:` is flagged with a one-click fix.
- **Highlight Similar Requests** colors the request it was made from, and the rule editor says why a rule colors fewer requests than expected.

## 0.5.2 (October 2026)

Mac only: the Linux beta stays on 0.5.1.

### New
- **Copy the paused request:** the Breakpoint window has a **Copy** menu (Copy URL, Copy as cURL, Copy as any code format, Copy Request, and Copy Response when a response is paused). It copies the message as Execute would send it, edits included, and the message stays paused.

### Fixed
- Searching the docs for "IDOR" or "BOLA" (`search_docs`, `cloakctl docs-search`) finds the Authorization Matrix first again, then API scan.

## 0.5.1 (October 2026)

For the Mac and the Linux beta. Security testing for your own APIs, native gRPC through decryption, and an MCP server with 148 tools.

### New
- **Scope:** list the hosts and paths you're allowed to test (include and exclude rules, or a Burp Suite scope). Replays, the Authorization Matrix and the fuzzer stay inside it, traffic outside it can be left unrecorded or blocked, and an assistant's request to widen it waits for your Allow. `cloakctl scope`, `cloakctl run --scope FILE`.
- **Tokens and sign-in:** every bearer token, JWT and session cookie in the traffic, with claims, expiry, where it came from and where it was sent, and each OAuth/OIDC sign-in as one timeline, with checks for weak signatures, missing expiry, tokens in URLs and sign-ins without `state` or PKCE. Passive: nothing is sent.
- **Request fuzzer:** payload positions, four attack modes and payload lists, with a rate cap, a confirmation, and only hosts in the scope. `cloakctl fuzz`.
- **API scan (Insights):** likely IDOR, mass assignment, missing rate limits, verbose errors, weak JWTs, CORS problems, GraphQL introspection and oversized queries, and request-smuggling signals, each with evidence and a fix. Passive.
- **Findings and reports:** severity, CVSS 3.1/4.0, CWE and OWASP references and redacted evidence; Add to Findings from the traffic list, inspector, Authorization Matrix, Insights, the fuzzer and AI Security; reports as PDF, HTML, Markdown, JSON, SARIF or Burp XML. `cloakctl findings`.
- **AI security:** flags prompt injection in tool results, MCP results and tool descriptions; pins each MCP server's tools and shows a diff when they change; checks prompts leaving for a model provider for keys and personal data (warn, redact or block).
- **Limit what AI assistants can see:** keep an MCP client to one app, some hosts, a query or highlighted requests, with or without bodies (Settings › AI Assistants). `cloakctl mcp --app/--host/--scope/--metadata-only` narrows it per connection.
- **Insomnia imports:** v5 YAML as well as v4 JSON and YAML, with every auth type, bodies, scripts, folders, environments and the cookie jar, and a list of anything that didn't come across.
- **Map Remote prefix swap** and **a pattern tester in every rule editor** (`cloakctl rules TOOL test`).
- **Cookie settings per request** in the API client.

### Improved
- Cloak Proxy removes `Alt-Svc` from decrypted responses so apps stay off HTTP/3 (Settings › General › HTTP/3).
- The certificate check reads Keychain Access's Never Trust setting, shows Valid until, and warns before the certificate expires.
- The Doctor finds why an iPhone or iPad sends nothing (Allow other devices, the macOS firewall, Internet Sharing) and notices booted simulators without the certificate.
- HAR files carry cookies, real timings, WebSocket messages and a marker on cut bodies, and the Summary tab shows timing rows.
- Left running for days: abandoned connections close after 10 idle minutes, the open-file limit is raised, the DNS cache is bounded and the log rotates.
- Accessibility: status dots have a shape as well as a color, VoiceOver reads each request as one sentence, every control has a name, and the app follows Increase Contrast and Reduce Motion.
- The MCP server has 148 tools.

### Fixed
- Native gRPC works through decryption: `grpc-status`, `grpc-message` and trailing metadata reach the app, and a new Trailers tab shows them. gRPC requests keep `TE: trailers`.
- WebSocket messages of any size pass through (the record keeps the first 1 MB), and `wss://` servers with a self-signed certificate or client certificates work.
- Uploads that wait for `Expect: 100-continue` no longer stall.
- A lost `adb reverse` is reported, with Re-run adb reverse.
- In the API client, cookies set on a redirect reach the next request, and a custom root certificate on realtime connections adds to the system's roots.
- Safari: the extension's popup no longer asks you to allow websites after Always Allow on Every Website.

### Linux beta
- Long sessions move big bodies to files, Install Everywhere covers Flatpak browsers and Firefox 147, removing the package stops trusting the certificate, no more blank window on NVIDIA, and a crashed proxy isn't restored.
- The engine changes above apply. The security testing tools have no windows on Linux yet: they work through `cloakctl` and the MCP tools.

## 0.5.0 (October 2026)

Mac only: the Linux beta stays on 0.4.2.

### New
- **App Capture: capture apps that ignore the proxy.** Go and Rust tools, `curl` and other command-line tools, Node.js scripts and many Electron apps connect straight to the internet whatever the macOS proxy says. App Capture (Proxy › Device & Runtime Setup… › App Capture) sends the apps you pick through Cloak Proxy anyway, with a network extension you allow once in System Settings. Their connections show up under the app's name, decrypted where SSL Proxying says so, with your rules applied. It's off by default, works app by app, blocks the picked apps' HTTP/3 so they fall back to TCP, and steps aside whenever Cloak Proxy isn't running. The Doctor suggests it for apps that skip the proxy, and `cloakctl app-capture` controls it from Terminal.
- **Safari extension:** the browser extension now comes inside Cloak Proxy for Safari too. Turn it on in Safari Settings › Extensions, pair it, and Safari's requests show their tab and frame, with console errors in bug reports. Safari can't record a single tab, so that stays Chrome, Edge, Brave and Firefox only.
- **Installer package for teams:** `Cloak-Proxy.pkg`, signed and notarized, installs Cloak Proxy from a device management service or `sudo installer`. Sample configuration profiles pre-approve the network extension, lock update checks and turn the Safari extension on for everyone.

### Changed
- The MCP server has 133 tools (`app_capture_status`, `set_app_capture`). Assistants can read App Capture's state; turning capture on for an app always asks you in Cloak Proxy first.
- Settings › General › Updates shows its switches locked when a configuration profile sets them.
- Uninstalling: remove App Capture's network extension first (Remove Extension…); the Homebrew cask does it for you.

### Fixed
- The browser extension's manifest carries the app's version (it said 0.4.1 since 0.4.1).

## 0.4.2 (October 2026)

Cloak Proxy is now **signed with a Developer ID and notarized by Apple**: it opens like any other app, with no Open Anyway step.

### New
- **Pausing recording keeps Cloak Proxy's hands off your traffic:** nothing is decrypted and no rules run, and decrypted connections close once their requests finish, so apps reconnect untouched. **Keep intercepting, just don't record** in Settings › General keeps the old behaviour.
- **Sign-in pages and bot checks are never decrypted by default:** Google, Apple Account, Microsoft and Okta sign-in hosts and Cloudflare's challenge host, each with a **Decrypt anyway** switch. The Doctor explains Cloudflare challenges and refused sign-ins, with **Stop decrypting**, and adding a whole browser to SSL Proxying warns first and offers the Capturing Browser.
- **Ask before AI features send anything:** the first time Agent Mode or an AI request sends to a provider, you see what goes where and allow it once per provider; **Settings › Privacy** lists and revokes them. Agent tools that change things ask too (Allow Once, Always, Deny), and unattended monitors and schedules deny and log them.
- **Workspace trust:** scripts and local MCP commands in a workspace you import, clone or pull don't run until you click **Trust**.
- **The upstream proxy covers everything:** tunnels Cloak Proxy doesn't decrypt, WebSockets and SOCKS5 with a username and password, plus a **Don't use it for** list and a Doctor finding when the proxy refuses.
- **WebSocket rules:** Block List, Map Remote, Rewrite and request breakpoints apply to WebSocket handshakes, and `ws://` / `wss://` rules match.
- **Java and Docker:** `cloakctl run`, the terminal setup and Docker capture set `JAVA_TOOL_OPTIONS` with a generated truststore, so JVMs go through the proxy; Docker build capture is opt-in.
- **Optional anonymous install counts** (off by default) and a **login check** that restores your network settings after a crash (Settings › General, off by default).

### Improved
- Large downloads stream straight through instead of being held in memory (the record keeps the first 32 MB), quiet streams and long-polls aren't cut after 2 minutes, and apps that wait for the server to speak first (SMTP, SSH, databases) work through CONNECT.
- Certificates follow the name the app asks for (SNI) when it connects by IP address, and handle hosts with a trailing dot.
- Scripts stop after 5 seconds instead of hanging every request, see binary bodies as `bodyBytes`, and keep header order.
- OAuth 2 tokens refresh automatically before they expire (with an off switch); the token request follows the request's SSL setting. API client WebSocket and gRPC requests can go through Cloak Proxy.
- With **Allow other devices** on and no device list, only devices on your local network can connect; the proxy also listens on IPv6 localhost, and the Doctor names the app holding a busy port and offers another.
- New network adapters get the system proxy while it's on, your proxy bypass list is kept, and an unplugged adapter no longer asks for your password.
- zstd responses are labelled instead of shown as garbage, and decoding stops at 64 MB.
- MCP tools say which are read-only, destructive or reach other hosts.

### Fixed
- **Copy as cURL** can no longer make curl upload a local file when a body starts with `@`.
- API client passwords and OAuth tokens stay out of Git-tracked workspace files and exports.
- A Git pull with conflicts no longer deletes collection files; the conflicted files are named.
- A damaged autosave is kept aside and its readable requests recovered, instead of being silently replaced.
- Quitting no longer restores another tool's dead proxy or leaves Cloak Proxy's own proxy on (no internet afterwards).
- HAR import of times without a time zone, and the Flutter setup no longer shows a made-up IP address.
- `cloakctl run` commands trust the system's certificates as well as Cloak Proxy's.

### Linux beta
- **RPM and AppImage:** Cloak Proxy for Linux now also comes as an RPM for Fedora 43+ and RHEL 10-compatible distributions (`sudo dnf install ./cloak-proxy-0.4.2-1.x86_64.rpm`), with the same certificate and DNS capture helpers as the `.deb`, and as an AppImage that runs on any distribution with WebKitGTK 6.0 without installing anything. The AppImage can't change the system's trusted certificates or capture apps through DNS, and says so; `--integrate` adds it to your app menu and puts `cloak-proxy` and `cloakctl` on your PATH.
- **Man pages:** `man cloak-proxy` and `man cloakctl`, in the `.deb`, the RPM, the AppImage and the portable folder.
- Automatic update checks are off until you turn them on, as on the Mac.

## 0.4.1 (October 2026)

### New
- **Query language** in the filter bar: `status:5xx app:ShopApp dur:>500ms gql:CreateOrder -host:cdn.*`, with autocomplete, saved queries, and **Highlight and Extract Rules** that tint rows and pull values into columns. `cloakctl query` runs the same queries on HAR files and sessions.
- **Live sharing:** Proxy › Share Live Traffic… gives a read-only link your colleague opens in a browser on the same network. Your computer serves it itself, secrets are hidden, and every share expires. Nothing is uploaded.
- **Browser extension** for Chrome, Edge, Brave and Firefox, loaded unpacked: each request gets its tab, page and initiator, one tab can be recorded without a proxy, and console errors go into bug reports.
- **API client:** `.http` files (VS Code REST Client and JetBrains), shared and inherited headers, environments based on another, `.env` files, preview tabs and Go to Request (⌘P).
- 131 MCP tools.

### Linux beta
- Nearly every Mac window is now on Linux: Privacy Map, Authorization Matrix, API Contracts, Release Diff, Make Tests, Compare Environments, Failure Scenarios, Distributed Tracing, the Doctor, Report Bug, DNS capture for apps that ignore the proxy (with Undo All System Changes), the in-app SDK listener, Protobuf settings and Decode As, certificate regeneration and your own CA, full menus, keyboard shortcuts and an update check, plus the API client's other protocols, runner, load tests, mocks, flows, monitors, specs, Git and Agent Mode.
- Fixed: a file-descriptor leak in API client scripts, launched apps and terminals ignoring quit signals and Ctrl-C, and `cloakctl mcp` hanging at the end of its input.

### Fixed
- A rare crash when a TCP, MQTT or WebSocket server hung up while the API client was connecting.

## 0.4.0 (October 2026)

### New
- **Cloak Proxy for Linux (beta)**: the same engine in a GTK window on Ubuntu 24.04+, Debian 13+ and other desktops with GTK 4 and WebKitGTK 6.0. Ships as a `.deb` and a portable `.tar.gz`. Capture and decryption, the traffic list and inspector, the debugging tools, breakpoints, Compose, Insights, the API client for HTTP and GraphQL, `cloakctl` and the MCP server; `cloak-proxy --headless` for servers and CI.
- **LLM Inspector**: an AI tab for OpenAI, Anthropic, Gemini, Ollama and compatible calls, with tokens, cost, time to first token, the context window breakdown, the prompt-cache break point, the prompt as a transcript and a replay of the streamed reply. Insights › AI adds up spend.
- **Streaming responses**: SSE, JSON-lines and multipart responses pass through as they arrive, with a live Messages tab and GraphQL subscriptions.
- **Edit Protobuf and gRPC as JSON** in breakpoints, Compose and Map Local; gRPC status for every call.
- **Rule conditions** (header, query, JSON body, GraphQL operation) for every tool, and a GraphQL Errors filter.
- **Rule folders and sets**: switch a whole scenario on or off.
- **Failure scenarios** (⌥⌘F): timeouts, resets, truncated and trickled bodies, first-N or percentage failures, with ten templates.
- **One-click capture targets**: a capturing browser profile (⇧⌘B), Electron apps, Docker Compose, Flutter and Android debug configs.
- **Distributed tracing**: W3C, B3, Jaeger, Datadog, X-Ray and Sentry headers, broken propagation, Open in your tracing backend.
- **Report Bug** (⇧⌥⌘B): a bundle with a summary, a redacted HAR, a replayable flow and an optional screen recording, or filed to GitHub, Jira or Linear.
- **Authorization matrix** (⌥⌘A): replay a session as other users to find IDOR / broken object-level authorization.
- **API contract checking** (⇧⌥⌘K): check live traffic against OpenAPI specs, with coverage.
- **Release diff** (⇧⌥⌘D): compare two builds' traffic endpoint by endpoint.
- **Make tests from traffic**, **Compare environments**, agent skills and redaction for AI assistants, and a Toxiproxy-compatible API. 118 MCP tools.

### Improved
- A redesigned Privacy Map, a centred toolbar, plain-language TLS errors, a list of servers without certificate checks, and essential Apple services (push, activation, app verification) are never decrypted.

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
