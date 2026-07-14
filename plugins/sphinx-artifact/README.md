Sphinx gives Claude access to approved internal knowledge through the Sphinx MCP server and a data-analysis workflow skill.

This directory is the installable Claude plugin root. It contains:

- `.claude-plugin/plugin.json` for plugin metadata.
- `.mcp.json` for the Sphinx MCP server.
- `skills/sphinx-knowledge-base-search/SKILL.md` for Sphinx data-analysis procedure guidance.
- `assets/` for plugin imagery.

Install this plugin through the marketplace at the repository root, or test locally with:

```bash
claude --plugin-dir ./plugins/sphinx-artifact
```
