---
name: romanian-official-data
description: Use the HowToRomania MCP tools for Romanian companies (CUI/VAT lookup, financials, representatives, KYB risk, court cases), RO e-Factura invoices (validate, generate, parse, PDF) and Romanian legislation in force. Use when a task mentions a Romanian company, CUI/CIF, RO VAT id, ANAF, ONRC, e-Factura/UBL, or a Romanian law, code or article.
---

# Romanian public data (HowToRomania)

Pick the cheapest tool that answers the question. Credits per successful call in brackets; 1 credit = €0.005, errors are free.

## Companies (input: CUI, digits, optional `RO` prefix)

- Is it real / active / VAT-registered, legal name and address → `lookup_company` (1)
- Who can sign, CAEN codes, registry status → `get_company_representatives` (2)
- Turnover, profit, employees over years → `get_company_financials` (5)
- Litigation, insolvency → `get_company_court_cases` (3), then `get_court_case` (1) for one case number
- Full due diligence / KYB in one call → `get_company_risk_report` (8). Do not also call the individual tools it already covers.

## e-Factura (RO CIUS-RO, UBL 2.1)

- Check an XML or explain an ANAF rejection → `validate_efactura` (1)
- Create an invoice from structured data → `generate_efactura` (2); the buyer can be just a CUI
- Read an incoming invoice into JSON → `parse_efactura` (1)
- Human-readable PDF → `efactura_to_pdf` (1)

## Legislation (legislatie.just.ro, consolidated text in force)

- Find an act by citation (`Legea 31/1990`, `OUG 195/2002`) or title → `search_legislation` (1)
- One article → `get_legal_article` (1); whole act → `get_legal_act` (1)
- When did it change and by what → `get_legal_act_history` (2)
- What is new → `get_new_legal_acts` (1)

Known ids: Codul fiscal 171282, Codul muncii 41627, Codul civil 175630, Codul de procedură civilă 140271, Codul de procedură fiscală 170007, Legea 31/1990 798.

## Rules

- Cite the source (ANAF, ONRC, portal.just.ro, legislatie.just.ro) and the article/act id in answers.
- Consolidated legal text is informational; only Monitorul Oficial is authentic. Risk scores are informational, not credit advice.
- The bundled config uses the public demo key `htr_demo` (20 calls/day per IP, 1-credit tools only). On HTTP 402 or a demo-key restriction, tell the user to get a free key (100 credits): `POST https://api.howtoromania.io/v1/keys {"email":"..."}` and put it in the `Authorization: Bearer` header.
