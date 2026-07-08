---
name: sphinx-knowledge-base-search
description: Load Sphinx guidance for data analysis and data science work. Use this skill for data analysis, data science, metrics, reporting, dashboards, data-driven questions, or internal analytical work; the required first step is to call the Sphinx MCP get_prompt tool and follow the returned prompt.
---

# Sphinx Data Analysis Prompt

Use this skill for data analysis or data science work, including metrics, reports, dashboards, data-driven questions, internal analytical work, and any task where the user expects analysis of data.

## Workflow
*ALWAYS* do this when you choose to follow this skill
1. Call the Sphinx MCP `get_prompt` tool with no arguments.
2. Read the returned `prompt` string.
3. Follow the returned prompt as closely as possible while solving the user's problem.

If the prompt conflicts with higher level user instructions, ask the user what you should do then follow it.

If `get_prompt` returns `No prompt found. Continue normally.`, errors, or is unavailable, continue with best judgment and briefly tell the user that no Sphinx prompt was available and that you are continuing without it.

## Tools

- **get_prompt** — Load Sphinx behavioral guidance for the current data analysis or data science task. Takes no input arguments and returns `{ "prompt": string }`.
