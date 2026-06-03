We recommend installing Sphinx as a plugin for your Claude account. This will allow it to be used across each of Claude.ai (the website), Claude Code, and Claude Cowork with a single install.

## Individual Installation

Note that individual installation is only possible for Claude users not belonging to a Team or Enterprise Claude account. Those users should instead refer to the team installation section.

1. Download this repository as a [.zip archive](https://github.com/sphinx-ml/sphinx-plugin/archive/refs/heads/main.zip).
2. From the Claude website, open the [**Customize** tab](https://claude.ai/customize), then select
Install the plugin from Claude's plugin UI. In Claude, open the [**Customize** tab](https://claude.ai/customize), then select **Personal plugins** >> **+** >> **Create plugin** >> **Upload plugin**, providing the .zip archive from the previous step.

1. From the Claude website, open the [**Customize** tab](https://claude.ai/customize), then select **Personal plugins** >> **+** >> **Create plugin** >> **Add marketplace**
2. Click on the URL field, type "sphinx-ml/sphinx-plugin" into the text input, click 'Use "sphinx-ml/sphinx-plugin"', then click "Sync".
3. In the plugins directory, select and install the Sphinx plugin.
4. Select the Sphinx connector within the Sphinx plugin, and click "Connnect" to authenticate with Sphinx.
5. Sphinx is now ready to use!

See also:

- [Use plugins in Claude](https://support.claude.com/en/articles/13837440-use-plugins-in-claude)
- [Install plugins](https://claude.com/docs/cowork/guide/plugins)
- [Discover and install plugin marketplaces](https://code.claude.com/docs/en/discover-plugins)

## Team Installation

Team-level installation of third-party plugins is not currently well supported by the Claude interface, so the following procedure may seem suboptimal. We are monitoring the Claude platform, and will update this as that team ships improvements.

You must be an Owner within your Claude organization to install new plugins.

1. Download this repository as a [.zip archive](https://github.com/sphinx-ml/sphinx-plugin/archive/refs/heads/main.zip).
2. Navigate to the [**Plugins** tab](https://claude.ai/admin-settings/plugins) of the organization settings page on the Claude website.
3. Select **Add plugins** >> **Upload a file**, and provide the .zip archive from step 1. Provide "Sphinx" for the marketplace name.
4. Find the Sphinx plugin within the plugins list, and configure "User access" according to your needs.
5. If access is set to "Available to install", users will need to manually install the Sphinx plugin from the [**Customize** tab](https://claude.ai/customize/plugins) on the Claude website.
6. Direct users to authenticate with Sphinx from the Sphinx connector [configuration page](https://claude.ai/customize/plugins/sphinx%40sphinx-plugin/connectors).
7. Sphinx is now ready to use!


See also:

- [Manage plugins for your organization](https://support.claude.com/en/articles/13837433-manage-plugins-for-your-organization)
- [Create and distribute a plugin marketplace](https://code.claude.com/docs/en/plugin-marketplaces)
- [MCP, plugins, skills, and hooks](https://claude.com/docs/cowork/3p/extensions)
