Sphinx gives agents access to approved internal knowledge, including company context, process guidance, metric definitions, customer context, and marketing information. This repository bundles the Sphinx knowledge-base instructions with the Sphinx MCP server configuration.

Sphinx can be installed either as a plugin in supported clients (recommended) or as a standalone MCP connector.

## Plugin Installation (recommended)

Client-specific installation instructions are provided below. Note that only users with pre-existing Sphinx accounts can use this plugin. If you are interested in trying Sphinx, contact our sales team.

- [Claude](.claude-plugin/README.md)
- [Codex](.codex-plugin/README.md)
- [Cursor](.cursor-plugin/README.md)

## MCP Connector Setup

Configure your MCP client to connect to the following MCP server URL:

```text
https://api.prod.sphinx.ai/mcp
```

The bundled MCP configuration registers the server as `sphinx`:

The Sphinx MCP server relies on OAuth authentication with Dynamic Client Registration (DCR). Most up-to-date MCP clients should support this out-of-the-box with no additional configuration.

## MCP Tools

- `search`: Search the Sphinx knowledge base with a natural-language query. Use vector search for conceptual questions and keyword search for exact terms.
- `fetch`: Retrieve the full text of a knowledge base page. Must follow a call to `search`.
- `suggest_edits`: Ask Sphinx to asynchronously improve the knowledge base based on natural-language guidance. The tool returns a URL where the created job can be monitored.

## Troubleshooting

- **Unable to install the Sphinx plugin/connector:** This action generally requires elevated permissions within your Claude/Cursor/Codex/etc account if you belong to a Team/Enterprise account. For instance, Claude only allows Owners (not Admins) to configure new plugins and connectors. Consult your sysadmin to add Sphinx.
- **Unable to authenticate with Sphinx:** Confirm that you have a valid Sphinx account by logging in to <https://app.sphinx.ai>. Note that a pre-existing Sphinx account is required; contact the Sphinx team to get started.
- **Server is not invoking Sphinx:** Some clients require an additional manual authentication/connection step after configuring the plugin/connector. Check your setup to ensure the Sphinx connector is authenticated and connected. 

If you encounter other issues, please contact our support team at <support@sphinx.ai>.