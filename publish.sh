#!/bin/bash
# Creates github.com/<owner>/cloak-proxy from this folder. The release workflow then
# mirrors the installer from download.subcloak.com as a GitHub release within the hour.
#   ./publish.sh subcloak
set -euo pipefail
# Commits are authored as Subcloak, so no personal name or email appears in the public history.
cd "$(dirname "$0")"
OWNER="${1:?Usage: ./publish.sh <github-org>}"

if [ "$OWNER" != "subcloak" ]; then sed -i '' "s#github.com/subcloak/cloak-proxy#github.com/$OWNER/cloak-proxy#g" README.md; fi
[ -d .git ] || git init -q -b main
git add README.md CHANGELOG.md SECURITY.md .github
git -c user.name="Subcloak" -c user.email="hello@subcloak.com" commit -qm "Cloak Proxy: README, changelog, security policy and issue forms" || true
gh repo create "$OWNER/cloak-proxy" --public --source . --push \
  --description "See every request your Mac makes. Free native macOS HTTPS debugging proxy with an API client and MCP server." \
  --homepage "https://subcloak.com/apps/cloak-proxy"
gh repo edit "$OWNER/cloak-proxy" --enable-wiki=false --enable-projects=false \
  --add-topic macos --add-topic proxy --add-topic https --add-topic debugging --add-topic mitm \
  --add-topic http-proxy --add-topic api-client --add-topic mcp --add-topic swift --add-topic ios-development

# Releases come from .github/workflows/release.yml (hourly, or now via the Actions tab),
# so they show the Actions bot as their author.
echo "Published https://github.com/$OWNER/cloak-proxy"
