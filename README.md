<p align="center">
  <img src="assets/logo-wide.png" alt="HowToRomania" width="560">
</p>

<p align="center"><b>Romania, readable by agents.</b></p>

<p align="center">
  <a href="https://smithery.ai/servers/ipa-netot/howtoromania"><img src="https://smithery.ai/badge/ipa-netot/howtoromania" alt="smithery badge"></a>
  <a href="https://registry.modelcontextprotocol.io/v0/servers?search=io.howtoromania/api"><img src="https://img.shields.io/badge/MCP%20Registry-io.howtoromania%2Fapi-blue" alt="MCP Registry"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-green" alt="MIT"></a>
</p>

Official Romanian data for AI agents: companies (ANAF, ONRC), financials, court cases, KYB risk, e-Factura and legislation in force. Remote MCP server + REST API. Pay per call, 100 free credits.

This repository holds the public docs, client configs and registry metadata. The server is hosted; there is nothing to install or run.

| | |
|---|---|
| MCP endpoint (Streamable HTTP) | `https://api.howtoromania.io/mcp` |
| Auth | `Authorization: Bearer <key>` |
| REST / OpenAPI | `https://api.howtoromania.io/openapi.json` |
| Demo key | `htr_demo` (20 calls/day per IP, 1-credit services only) |

## Services and prices

1 credit = €0.005. Billed only on success; errors and not-found are free.

| Tool | What it returns | Credits |
|---|---|---:|
| `lookup_company` | ANAF registry data by CUI/VAT: name, address, status, VAT, e-Factura, BNR EUR/RON rate | 1 |
| `get_company_financials` | Up to 5 years of filed accounts + ratios (RON) | 5 |
| `get_company_representatives` | Trade-register status, CAEN codes, legal representatives (ONRC) | 2 |
| `get_company_risk_report` | KYB in one call: status + financials + court cases + registry, score 0-100 with explained flags | 8 |
| `get_company_court_cases` | Cases where the company is a party (portal.just.ro), summary + list | 3 |
| `get_court_case` | One case by number: parties, hearings, outcomes, appeals | 1 |
| `validate_efactura` | ANAF official CIUS-RO validator + local checks, with rule codes | 1 |
| `generate_efactura` | CIUS-RO UBL invoice from simple JSON; parties auto-filled from CUI; ANAF-validated | 2 |
| `parse_efactura` | UBL Invoice/CreditNote XML → clean English JSON | 1 |
| `efactura_to_pdf` | ANAF official PDF rendering of an e-Factura XML | 1 |
| `search_legislation` | Find acts by citation (`Legea 31/1990`) or title words | 1 |
| `get_legal_act` | Current consolidated text, split by article | 1 |
| `get_legal_article` | One article in force + dated amendment notes | 1 |
| `get_legal_act_history` | Consolidation dates and dated amendments per article | 2 |
| `get_new_legal_acts` | Acts in force since a date (max 35 days) | 1 |

### Credit packs

| Pack | Price | Per credit |
|---|---:|---:|
| 1,000 credits | €5 | €0.0050 |
| 5,000 credits | €20 | €0.0040 |
| 30,000 credits | €100 | €0.0033 |

Every new key gets **100 free credits**. Out of credits → HTTP 402 with checkout links. Balance: `GET /v1/me`.

## Get a key

```bash
curl -X POST https://api.howtoromania.io/v1/keys \
  -H "content-type: application/json" \
  -d '{"email":"you@example.com"}'
# → {"apiKey":"htr_..."}   (shown once)
```

No signup needed to try: use the public demo key `htr_demo` (20 calls/day per IP; `lookup_company`, `get_court_case`, `validate_efactura`, `parse_efactura`, `search_legislation`, `get_legal_article`, `get_new_legal_acts`).

## Connect

Replace `htr_demo` with your own key. Ready-made files are in [`examples/`](examples/).

### Cursor

`~/.cursor/mcp.json` ([examples/cursor.json](examples/cursor.json))

```json
{
  "mcpServers": {
    "howtoromania": {
      "url": "https://api.howtoromania.io/mcp",
      "headers": { "Authorization": "Bearer htr_demo" }
    }
  }
}
```

### VS Code

`.vscode/mcp.json` ([examples/vscode.json](examples/vscode.json)), prompts for the key:

```json
{
  "inputs": [
    { "type": "promptString", "id": "htr-key", "description": "HowToRomania API key", "password": true }
  ],
  "servers": {
    "howtoromania": {
      "type": "http",
      "url": "https://api.howtoromania.io/mcp",
      "headers": { "Authorization": "Bearer ${input:htr-key}" }
    }
  }
}
```

### Cline

`cline_mcp_settings.json` ([examples/cline.json](examples/cline.json))

```json
{
  "mcpServers": {
    "howtoromania": {
      "type": "streamableHttp",
      "url": "https://api.howtoromania.io/mcp",
      "headers": { "Authorization": "Bearer htr_demo" },
      "disabled": false
    }
  }
}
```

### Windsurf

`~/.codeium/windsurf/mcp_config.json` ([examples/windsurf.json](examples/windsurf.json))

```json
{
  "mcpServers": {
    "howtoromania": {
      "serverUrl": "https://api.howtoromania.io/mcp",
      "headers": { "Authorization": "Bearer htr_demo" }
    }
  }
}
```

### Claude Desktop (and any client without remote-header support)

`claude_desktop_config.json`, via [`mcp-remote`](https://www.npmjs.com/package/mcp-remote) (needs Node.js 18+) ([examples/claude-desktop.json](examples/claude-desktop.json))

```json
{
  "mcpServers": {
    "howtoromania": {
      "command": "npx",
      "args": [
        "-y", "mcp-remote", "https://api.howtoromania.io/mcp",
        "--header", "Authorization:Bearer ${HTR_API_KEY}"
      ],
      "env": { "HTR_API_KEY": "htr_demo" }
    }
  }
}
```

### Claude Code

```bash
claude mcp add --transport http howtoromania https://api.howtoromania.io/mcp \
  --header "Authorization: Bearer htr_demo"
```

### Agent Plugins / Cursor plugin

This repo is also a plugin following the [Open Plugins / Agent Plugins](https://open-plugins.com) standard: [`plugin.json`](plugin.json) + [`mcp.json`](mcp.json) (remote server), [`.mcp.json`](.mcp.json) and [`.cursor-plugin/plugin.json`](.cursor-plugin/plugin.json) for Cursor, and a skill in [`skills/romanian-official-data`](skills/romanian-official-data/SKILL.md) that tells agents which tool to use. The bundled config uses the demo key; swap in your own key after install.

### REST

```bash
curl -H "x-api-key: htr_demo" https://api.howtoromania.io/v1/company/14399840
```

## Example prompts

- "Before we sign with supplier RO14399840, check it's active, VAT-registered, and summarize risk flags." → `get_company_risk_report` (8)
- "List the legal representatives of CUI 14399840 and their roles." → `get_company_representatives` (2)
- "ANAF rejected this XML. Which rules fail and how do I fix them?" → `validate_efactura` (1)
- "What VAT rates apply in Romania today per Codul fiscal art. 291, and when did they last change?" → `get_legal_article` (1) + `get_legal_act_history` (2)

## Listed on

- Official MCP Registry: `io.howtoromania/api` ([server.json](server.json))
- Smithery: https://smithery.ai/servers/ipa-netot/howtoromania
- Glama: https://glama.ai/mcp/connectors/io.howtoromania/api

## Data sources

ANAF (company registry, financial statements, e-Factura validator and PDF), BNR (exchange rates), ONRC open data (trade register), portal.just.ro (court cases), legislatie.just.ro (legislation). Court data masks natural persons. Consolidated legal text is informational; only Monitorul Oficial is authentic.

**Informational; not legal or credit advice.**

## Links

- Site and docs: https://howtoromania.io
- OpenAPI: https://api.howtoromania.io/openapi.json
- For agents: https://howtoromania.io/llms.txt
- Contact: hello@howtoromania.io

## License

[MIT](LICENSE) © 2026 HowToRomania. Covers the contents of this repository (docs, configs, metadata); the hosted service is subject to its own terms.
