{ config, pkgs, lib, ... }:

{
  # Claude Code MCP Server Configuration
  #
  # This creates an MCP configuration file that can be used with Claude Code
  # using the --mcp-config flag, or manually merged into ~/.claude.json
  #
  # The hexdocs-mcp server provides semantic search of Hex documentation
  # for Elixir projects. It requires Elixir and Mix to be installed.

  home.file.".claude/mcp-servers.json" = {
    text = builtins.toJSON {
      mcpServers = {
        hexdocs-mcp = {
          command = "npx";
          args = [
            "-y"
            "hexdocs-mcp@0.5.0"
          ];
        };
      };
    };
  };
}
