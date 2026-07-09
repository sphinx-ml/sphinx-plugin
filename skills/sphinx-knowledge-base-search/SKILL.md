---
name: sphinx-knowledge-base-procedure
description: Use this skill for data analysis, data science, metrics, reporting, dashboards, data-driven questions, or internal analytical work.
---

# Sphinx Data Analysis Procedure

Use this skill for any data analysis or data science work — metrics, reports, dashboards, data-driven questions, internal analytical work, and any task where the user expects analysis of data.

## Purpose

This page is the default SOP for performing any analysis. It covers how to:

- Work in the approved analytical environment.
- Use approved tables and default filters.
- Clarify ambiguous requests before writing SQL.
- Verify results against benchmarks when available.
- Execute notebooks cleanly.
- Preserve reusable knowledge in the wiki and claims manifests.

---

## Primary Problem-Solving Workflow

Every analysis request follows the same top-level decision procedure. This governs **how** the agent decides to proceed and takes precedence over the more detailed scoping and notebook mechanics below (which describe how to execute once a path is chosen). Follow these steps as closely as possible.

### 1. Search for an existing procedure first

Check **both** locations before starting any bespoke work:

- **This master prompt** — already in your context; scan it for a relevant procedure.
- **The Sphinx knowledge base** — reached via the MCP `search` and `fetch` tools; search for documented procedures, cookbook patterns, or prior analyses that answer the question.

Read candidate knowledge base pages **in full** with `fetch` rather than relying on search snippets.

### 2. If a matching procedure exists, follow it

- Tell the user you are following a procedure, and which one.
- Follow the documented procedure as written rather than improvising an equivalent — reusing sanctioned procedures is always preferred over rebuilding from scratch.
- Use the procedure as a guide, and still search the knowledge base for company-wide best practices and follow those.

### 3. If no procedure exists, run a bespoke analysis and capture it

- Tell the user you are **not** following a procedure and are doing a bespoke analysis.
- Perform the analysis using the standard scoping, notebook, and validation workflow.
- Once complete, write the new procedure back using the `suggest_edits` MCP tool so this class of analysis becomes reusable in future sessions. **THIS IS A CRITICAL STEP AND SHOULD NOT BE IGNORED**

### 4. In every case, upload an artifact for auditing

Regardless of which path you take, upload an artifact to the artifact store so the work is auditable later:

1. Mint a short-lived access token with `mint_artifact_store_jwt`.
2. Upload to the artifact server (see [Uploading an Artifact File](#uploading-an-artifact-file)).

Guidelines:

- Choose a descriptive title an auditor would search for — one that identifies the business question, subject, and date, not a generic filename.
- Only upload once the analysis is complete.
- **The artifact must be the Jupyter notebook used in the analysis. All artifacts should be Jupyter notebooks for later audit.**
- The title is the title of a file it must have a proper suffix
- Do not defer this to the user and do not ask for permission — just upload it. This is completely safe. The workflow is not complete until this is done.

---

## Notebook Structure

The standard analysis deliverable is a Jupyter notebook with a fixed structure. Each logical function or metric block should be introduced by a markdown cell explaining **why** it exists, not just what the code does.

### Required components

- **Title and purpose cell** with the exact user prompt or confirmed augmented prompt.
- **AI-generated analysis disclaimer** in every notebook.
- **First-time analysis disclaimer** when no similar prior analysis exists; otherwise use an optional provenance note instead.
- **Imports and configuration** that resolve the output directory and repository root robustly.
- **Database connection section** using canonical helpers.
- **Data loading section** with SQL inline, visible row counts, dtypes, and sample rows.
- **Reference verification section** when matching benchmarks exist.
- **One markdown-plus-code section per metric group.**
- **Visualization setup section** using the canonical plotting helpers.
- **Final markdown cell** summarizing key findings, distinguishing new vs. confirmed knowledge, and noting artifact tracking.

### Number discipline

Every stakeholder-facing number must be produced by notebook cell output — never mental math or undocumented hand-calculation. Print intermediate row counts, sanity checks, and aggregation outputs visibly in the notebook.

---

## Visualization and Notebook Code Standards

Visualization helpers should come from the single canonical plotting helper module rather than being copied into each project. Notebook code may include analysis-specific helper logic, but shared chart primitives should stay centralized. Reload the plotting helper module before import so changes are picked up consistently.

### Standard chart rules

- Focus series uses the standard blue color.
- Comparison / non-focus series use gray.
- Legend position is upper right, with no frame.
- Bar labels use the canonical bar-annotation helper rather than manual, repetitive `ax.text()` loops.
- Horizontal-bar axis padding is left to the annotation helper unless a later adjustment is necessary.
- Stacked bars show centered segment labels.

### Other standards

- Always save charts to disk and render them inline via the canonical `save_chart` helper — do not rely on `plt.show()` alone.
- When adding event spans to plots, call `set_ylim` first so labels anchor correctly.
- For any scalar division where the denominator might be zero, use the canonical `div0()` helper instead of bare division, so ratios and percent-change calculations are robust to zero-denominator cases.

---

## Notebook Execution and Auto-Fix Loop

After a notebook is written or extended:

1. Execute it.
2. Inspect the resulting notebook JSON for cell errors.
3. Fix any errors and retry, up to a bounded number of rounds, before presenting the notebook as complete.

The goal is to deliver a clean, executable notebook rather than an untested draft.

- User-facing communication should mention only the final clean state, or — if retries fail — a concise summary of unresolved errors and attempted fixes. Do not show intermediate failed runs.
- If automated execution is not possible in the environment, skip execution silently and add a comment instructing manual execution in the approved notebook environment.

---

## Persistent Knowledge Layer

The persistent knowledge layer retains reusable dataset schemas, business context, learnings, reusable SQL patterns, and prior analysis history — so agents and analysts can start each session with the right context instead of rebuilding it from scratch. This is what you should interact with to update and change the knowledge base.

### Knowledge base access via the Sphinx MCP

All reads from and writes to the persistent knowledge layer go through the Sphinx MCP server rather than ad hoc file access. Treat these tools as the canonical interface for loading context during session bootstrap, resolving metrics and table semantics before writing SQL, and preserving reusable knowledge after an analysis completes.

**Available MCP tools:**

- **`search`** — Searches the authenticated user's Sphinx company knowledge base for internal data, context, procedures, metrics, terminology, and project-specific documentation. Returns up to 10 results from main; supports keyword or vector search and optional `nodeType` filtering. Use it first to locate relevant pages rather than assuming a page's contents.
- **`fetch`** — Fetches one knowledge base page by id after a search, returning the page title, full text/body, and canonical URL. Read the complete page with `fetch` before answering or making a decision; do not act on a search snippet alone.
- **`suggest_edits`** — Starts an asynchronous knowledge base update from natural-language instructions when content is missing, stale, inaccurate, or needs improvement. Returns a `jobId` and a review/progress URL. Use it to capture reusable learnings, new cookbook patterns, or corrections rather than leaving knowledge trapped in a one-off notebook.
- **`get_prompt`** — Feature-gated by `artifact_store_enabled`. Returns a prompt intended to change the client's behavior to better achieve its goal.
- **`mint_artifact_store_jwt`** — Feature-gated by `artifact_store_enabled`. Mints a short-lived JWT for artifact-store operations, bound to the current MCP project and authenticated user. Required before any artifact upload.

**Standard usage pattern:** `search` to find candidate pages → `fetch` to read the authoritative page in full → proceed with analysis. When knowledge is missing or wrong, file a `suggest_edits` update rather than working around it silently.

---

## Uploading an Artifact File

To upload an artifact, first mint a JWT with `mint_artifact_store_jwt`, then POST the artifact to the artifact-store service. The payload must be base64-encoded.

The minted JWT is short-lived and scoped to the current MCP project and user, so mint it immediately before upload rather than caching it across a long session.

### Option A — Upload with an inline payload

```bash
curl -X POST "http://localhost:8000/artifact_store.ArtifactStoreService/UploadArtifact" \
  -H "Content-Type: application/json" \
  -H "X-Sphinx-Artifact-Store-JWT: $ARTIFACT_STORE_JWT" \
  -H "X-Sphinx-Version: 1.0.0" \
  --data '{
    "title": "example.txt",
    "payload": "SGVsbG8sIHdvcmxkIQ=="
  }'
```

### Option B — Upload directly from a file

Base64-encode first, then POST:

```bash
FILE="example.txt"
PAYLOAD=$(base64 -w 0 "$FILE")

curl -X POST "http://localhost:8000/artifact_store.ArtifactStoreService/UploadArtifact" \
  -H "Content-Type: application/json" \
  -H "X-Sphinx-Artifact-Store-JWT: $ARTIFACT_STORE_JWT" \
  -H "X-Sphinx-Version: 1.0.0" \
  --data "{
    \"title\": \"$(basename "$FILE")\",
    \"payload\": \"$PAYLOAD\"
  }"
```