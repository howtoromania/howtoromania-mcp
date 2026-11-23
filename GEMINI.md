# HowToRomania

Use these tools for Romanian companies, e-Factura invoices and legislation in force. Pick the cheapest tool that answers the question. Credits are charged per successful call; 1 credit = €0.005. Errors, not-found and source outages (for example ANAF unreachable) are not billed. A risk report with some sections unavailable is billed in full. BNR rate tools and identifier format checks are free and do not require a key.

Cite the source (ANAF, ONRC, portal.just.ro, legislatie.just.ro, bnr.ro) and the act or article id in answers. Consolidated legal text is informational; only Monitorul Oficial is authentic. Risk scores are informational, not credit or legal advice. Not a KYC/AML check: a valid IBAN does not prove account ownership.

## Companies (input: CUI, digits, optional `RO` prefix)

- Is it real, active or VAT-registered; legal name and address → `lookup_company` (1)
- Who can sign, CAEN codes, registry status → `get_company_representatives` (5)
- Turnover, profit, employees over years → `get_company_financials` (3)
- Litigation or insolvency → `get_company_court_cases` (15), then `get_court_case` (1) for one case number
- Due diligence / KYB in one call → `get_company_risk_report` (30). Do not also call the individual tools it already covers.
- Check data extracted from an invoice or contract before saving or paying → `validate_extracted_company_data` (2; +5 with legal representative, +1 with invoice block). Format-only check, free, no key → `check_identifier_format` (does not check that the company exists).

## e-Factura (CIUS-RO, UBL 2.1)

- Check an XML or explain an ANAF rejection → `validate_efactura` (1)
- Create an invoice from structured data → `generate_efactura` (2); the buyer can be just a CUI
- Read an incoming invoice into JSON → `parse_efactura` (1)
- Human-readable PDF → `efactura_to_pdf` (1)

## Legislation (legislatie.just.ro, consolidated text in force)

- Find an act by citation (`Legea 31/1990`, `OUG 195/2002`) or title words → `search_legislation` (1)
- One article → `get_legal_article` (1); whole act → `get_legal_act` (1)
- When it changed and by what → `get_legal_act_history` (2)
- What is new since a date → `get_new_legal_acts` (1)

Known ids: Codul fiscal 171282, Codul muncii 41627, Codul civil 175630, Codul de procedură civilă 140271, Codul de procedură fiscală 170007, Legea 31/1990 798.

## Rates

- BNR RON reference rate → `get_bnr_exchange_rate` (0)
- ROBOR fixing → `get_robor` (0)
- IRCC → `get_ircc` (0)

If a tool returns HTTP 402, the key is out of credits. Tell the user to check `GET https://api.howtoromania.io/v1/me` and to buy credits at https://howtoromania.io. If auth fails, they can issue a key with `POST https://api.howtoromania.io/v1/keys` and set it as the extension API key (`HTR_API_KEY`, sent as `Authorization: Bearer`).
