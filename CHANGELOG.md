# Changelog

Full release notes, with links to the docs for each feature: https://docs.subcloak.com/cloak-proxy/reference/release-notes/

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
