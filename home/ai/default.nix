{
  programs.claude-code = {
    enable = true;
    # Written to ~/.claude/CLAUDE.md, loaded by every Claude Code session.
    context = ./CLAUDE.md;
    # Symlinked into ~/.claude/agents/; they share the brain at ~/repos/brain.
    agentsDir = ./agents;
  };

  programs.codex = {
    enable = true;
    context = ./AGENTS.md;
  };
}
