# Installing HowToRomania MCP

HowToRomania is a **hosted remote MCP server** (Streamable HTTP). Nothing to clone, build or run locally.

- Endpoint: `https://api.howtoromania.io/mcp`
- Auth header: `Authorization: Bearer <API_KEY>`

## 1. Get an API key

Ask the user for their email, then:

```bash
curl -X POST https://api.howtoromania.io/v1/keys \
  -H "content-type: application/json" \
  -d '{"email":"USER_EMAIL"}'
```

The response is `{"apiKey":"htr_..."}`. It is shown only once; store it in the config below. Each key includes 100 free credits.

If the user does not want to register yet, use the public demo key `htr_demo` (20 calls/day per IP, 1-credit tools only).

## 2. Add the server to Cline

Add this entry to `cline_mcp_settings.json` under `mcpServers`, replacing `htr_demo` with the key from step 1:

```json
{
  "mcpServers": {
    "howtoromania": {
      "type": "streamableHttp",
      "url": "https://api.howtoromania.io/mcp",
      "headers": {
        "Authorization": "Bearer htr_demo"
      },
      "disabled": false
    }
  }
}
```

If the client cannot send headers to a remote server, use the stdio bridge instead (requires Node.js 18+):

```json
{
  "mcpServers": {
    "howtoromania": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://api.howtoromania.io/mcp", "--header", "Authorization:Bearer ${HTR_API_KEY}"],
      "env": { "HTR_API_KEY": "htr_demo" }
    }
  }
}
```

## 3. Verify

Call `lookup_company` with `{"cui": "14399840"}`. It should return the company name, address and VAT status from ANAF.

## Notes

- 15 tools: companies, financials, representatives, risk report, court cases, e-Factura (validate/generate/parse/PDF), legislation.
- 1 credit = €0.005; errors are not billed. Balance: `GET https://api.howtoromania.io/v1/me`.
- Docs: https://howtoromania.io · Contact: hello@howtoromania.io
