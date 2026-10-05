---
name: sphinx-knowledge-base-search
description: Searches the organization's Sphinx knowledge base of reviewed internal knowledge — its past work (projects, clients, deals, engagements), documents, processes, metrics, data sources, and terminology. Use before answering any question about the organization's own history, records, or practices, such as "have we ever…", "which of our…", "what's our most recent…", "how do we calculate ARR?", or "what's our process for…", and before using other connectors or skills for internal context.
---

# Sphinx Knowledge Base

## Find
- `search` returns at most 10 results. For broad questions, run several narrower searches (by name, sub-topic, or synonym) rather than one broad one.
- Use `searchType: "keyword"` for names, IDs, and quoted phrases; the default `hybrid` for everything else.
- `nodeType` limits results to one kind of page: Definition (concept or entity), Procedure (standard procedure or analytical process), Metric (metric or KPI), Data (data object inferred from usage), DataSource (indexed data source schema), Prompt (project prompt).
- `fetch` every page you rely on. Search snippets are not enough.

## Reading pages
- `@[Title](<page id>)` links to another page. Pass that id to `fetch` to follow it.
- `{{ref:<id>:<label>}}` cites the source of the text just before it; the label names the source document.
- `<SPHINX_CONTROVERSY>` marks an unresolved conflict between sources, sometimes with `<SPHINX_RESOLUTION_OPTION>` alternatives. Don't treat either side as settled; if it affects the answer, tell the user the sources disagree and give each position.
- `<data_stub>` means the page describes a data object Sphinx inferred from how it is used; its contents were not indexed.

## Answer
- Lead with the direct answer, then the supporting evidence.
- Cite each page you relied on by title and URL, plus the underlying source documents the page names, if available.
- If the knowledge base is missing or wrong on something, suggest a fix with `suggest_edits` and give the user the returned link.
