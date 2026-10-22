# HowToRomania MCP — stdio bridge to the hosted remote server.
# The server itself runs at https://api.howtoromania.io/mcp (streamable HTTP).
# This image only proxies stdio <-> HTTP via mcp-remote so registries can introspect it.
FROM node:22-alpine
ENV HTR_API_KEY=htr_demo
RUN npm install -g mcp-remote@latest
CMD ["sh", "-c", "mcp-remote https://api.howtoromania.io/mcp --header \"Authorization: Bearer ${HTR_API_KEY}\""]
