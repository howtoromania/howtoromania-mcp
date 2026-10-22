# REST examples

Base URL `https://api.howtoromania.io`, header `Authorization: Bearer <key>` (demo: `htr_demo`). Full reference: https://api.howtoromania.io/docs

```bash
K="Authorization: Bearer htr_demo"
B=https://api.howtoromania.io

# Free key (100 credits)
curl -X POST $B/v1/keys -H "Content-Type: application/json" -d '{"email":"you@example.com"}'

# Company
curl -H "$K" $B/v1/company/14399840
curl -H "$K" "$B/v1/company/14399840/financials?years=3"
curl -H "$K" $B/v1/company/14399840/representatives
curl -H "$K" $B/v1/company/14399840/risk-report
curl -H "$K" "$B/v1/company/14399840/court-cases?limit=10"

# Court case by number (URL-encode the slashes)
curl -H "$K" $B/v1/court-cases/9430%2F271%2F2025

# e-Factura
curl -H "$K" -H "Content-Type: application/xml" --data-binary @invoice.xml $B/v1/efactura/validate
curl -H "$K" -H "Content-Type: application/xml" --data-binary @invoice.xml $B/v1/efactura/parse

# Legislation
curl -H "$K" "$B/v1/legislation/search?q=Codul%20fiscal"
curl -H "$K" $B/v1/legislation/act/171282/article/291
curl -H "$K" $B/v1/legislation/act/171282/history
curl -H "$K" "$B/v1/legislation/new?since=2026-10-01"

# Account
curl $B/v1/pricing
curl -H "$K" $B/v1/me
```
