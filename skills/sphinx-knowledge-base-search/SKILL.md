---
name: sphinx-knowledge-base-procedure
description: Use this skill for data analysis, data science, metrics, reporting, dashboards, data-driven questions, or internal analytical work
---

# Sphinx Data Analysis Prompt

Use this skill for data analysis or data science work, including metrics, reports, dashboards, data-driven questions, internal analytical work, and any task where the user expects analysis of data.

Purpose
Use this page as the default SOP for performing any analysis: work in the approved analytical environment, use approved tables and default filters, clarify ambiguous requests before writing SQL, verify results against benchmarks when available, execute notebooks cleanly, and preserve reusable knowledge in the wiki and claims manifests. [sphinx_context_flat/knowledge**organizations**oats-overnight\_\_manifest.yaml](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed) [sphinx_context_flat/analyze\_\_SKILL.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
Primary problem-solving workflow
Every analysis request follows the same top-level decision procedure. This governs _how_ the agent decides to proceed and takes precedence over the more detailed scoping and notebook mechanics documented below, which describe how to execute once a path is chosen.
Always try to follow these steps as close as possible.
Search for an existing procedure first — in both the context file and the knowledge base. Documented procedures live in two places: this master prompt, which the agent already has in context, and the Sphinx knowledge base, reached via the MCP search and fetch tools. Check both before starting any bespoke work: scan this file for a relevant procedure and search the knowledge base for documented procedures, cookbook patterns, or prior analyses that answer the question. Read candidate knowledge base pages in full with fetch rather than relying on search snippets.
If a matching procedure exists, follow it. Let the user know that you are following a procedure and which one. When a documented procedure from either source can be used to answer the question, follow it as written rather than improvising an equivalent. Reusing sanctioned procedures is always preferred over rebuilding one from scratch. When you use a procedure, use it a guide on how to solve the problem. Still make sure you search the knowledge base for company wide best practices on what to do and follow those.
If no procedure exists, run a bespoke analysis and capture it. Let the user know that you are not following a procedure and that you are doing a bespoke analysis. If no existing procedure fits, perform a bespoke analysis using the standard scoping, notebook, and validation workflow. Once the analysis is complete, write the new procedure back using the suggest_edits MCP tool so this class of analysis becomes reusable for future sessions.
In every case, upload an artifact for auditing. Regardless of which path is taken, upload an artifact to the artifact store so the work is auditable later. First mint a short-lived access token with mint_artifact_store_jwt, then upload to the artifact server (see "Uploading an artifact file"). Choose a descriptive title that an auditor would search for — one that identifies the business question, subject, and date rather than a generic filename. Only choose to upload the artifact when the analysis is complete. This artifact will potentially be reviewed by someone else later. _Always package and upload according to the roles below so someone can audit it. Do not defer to users for this. The workflow is not complete until you do this part_ . Do not ask the user for permission, just go and upload the artifact. This is completely safe to do. The artifact should be the jupyter notebook used in the analysis. _ALL ARTIFACTS SHOULD BE JUPYTER NOTEBOOKS FOR LATER AUDIT_
Notebook structure
The standard analysis deliverable is a Jupyter notebook with a fixed structure. Each logical function or metric block should be introduced by a markdown cell that explains why it exists, not just what the code does. [sphinx_context_flat/analyze\_\_SKILL.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
Required notebook components include:
Title and purpose cell with the exact user prompt or confirmed augmented prompt.
AI-generated analysis disclaimer in every notebook.
First-time analysis disclaimer when no similar prior analysis exists; otherwise use an optional provenance note instead.
Imports and configuration that resolve the output directory and repository root robustly.
Database connection section using canonical helpers.
Data loading section with SQL inline, visible row counts, dtypes, and sample rows.
Reference verification section when matching benchmarks exist.
One markdown-plus-code section per metric group.
Visualization setup section using the canonical plotting helpers.
Claims manifest code cell that writes claims.json.
Final markdown cell summarizing key findings, distinguishing new vs. confirmed knowledge, and noting artifact tracking. [sphinx_context_flat/analyze\_\_SKILL.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
Every stakeholder-facing number should be produced by notebook cell output rather than mental math or undocumented hand-calculation. Intermediate row counts, sanity checks, and aggregation outputs should be printed visibly in the notebook. [sphinx_context_flat/analyze\_\_SKILL.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
Visualization and notebook code standards
Visualization helpers should come from the single canonical plotting helper module rather than being copied into each project. Notebook code may include analysis-specific helper logic, but shared chart primitives should remain centralized. The notebook should reload the plotting helper module before import so changes are picked up consistently. [sphinx_context_flat/analyze\_\_SKILL.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
Standard chart rules include:
focus series uses the standard blue color;
comparison or non-focus series use gray;
legend position is upper right with no frame;
bar labels should use the canonical bar-annotation helper rather than manual repetitive ax.text() loops;
horizontal-bar axis padding should be left to the annotation helper unless a later adjustment is necessary;
stacked bars should show centered segment labels. [sphinx_context_flat/analyze\_\_SKILL.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
Charts should always be saved to disk and rendered inline via the canonical save_chart helper; analysts should not rely on plt.show() alone. When event spans are added to plots, set_ylim should be called first so labels anchor correctly. [sphinx_context_flat/analyze\_\_SKILL.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
Any scalar division where the denominator might be zero should use the canonical div0() helper instead of bare division, so notebook ratios and percent-change calculations are robust to zero-denominator cases. [sphinx_context_flat/analyze\_\_SKILL.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
Notebook execution and auto-fix loop
After a notebook is written or extended, the standard procedure is to execute it, inspect the resulting notebook JSON for cell errors, fix errors, and retry up to a bounded number of rounds before presenting the notebook as complete. The goal is to deliver a clean, executable notebook rather than an untested draft. User-facing communication should mention only the final clean state or, if retries fail, a concise summary of unresolved errors and attempted fixes. Intermediate failed runs should not be shown. [sphinx_context_flat/analyze\_\_SKILL.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
If automated notebook execution is not possible in the environment, analysts should skip execution silently and add a comment instructing manual execution in the approved notebook environment. [sphinx_context_flat/analyze\_\_SKILL.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
Persistent knowledge layer
Its purpose is to retain reusable dataset schemas, business context, learnings, reusable SQL patterns, and prior analysis history so that agents and analysts can start each session with the right context instead of rebuilding it from scratch. [sphinx_context_flat/knowledge\_\_README.md](/knowledge-base/projects/6a4e647f4156e144c9319b0c/ingest/6a4e65df0167ff1a13e2ceed)
Knowledge base access via the Sphinx MCP
All reads from and writes to the persistent knowledge layer go through the Sphinx MCP server rather than ad hoc file access. Treat these tools as the canonical interface for loading context during session bootstrap, resolving metrics and table semantics before writing SQL, and preserving reusable knowledge after an analysis completes.
Available MCP tools:
search — Searches the authenticated user's Sphinx company knowledge base for internal data, context, procedures, metrics, terminology, and project-specific documentation. Returns up to 10 results from main; supports keyword or vector search and optional nodeType filtering. Use this first to locate relevant pages rather than assuming a page's contents.
fetch — Fetches one Sphinx knowledge base page by id after a search, returning the page title, full text/body, and canonical URL. Read the complete page with fetch before answering or making a decision; do not act on a search snippet alone.
suggest_edits — Starts an asynchronous Sphinx knowledge base update from natural-language instructions when content is missing, stale, inaccurate, or needs improvement. Returns a jobId and a review/progress URL. Use this to capture reusable learnings, new cookbook patterns, or corrections rather than leaving knowledge trapped in a one-off notebook.
get_prompt — Feature-gated by artifact_store_enabled. Returns a prompt intended to change the client's behavior to better achieve its goal.
mint_artifact_store_jwt — Feature-gated by artifact_store_enabled. Mints a short-lived JWT for artifact-store operations bound to the current MCP project and authenticated user. Required before any artifact upload.
Standard usage pattern: search to find candidate pages, fetch to read the authoritative page in full, then proceed with analysis. When knowledge is missing or wrong, file a suggest_edits update rather than working around it silently.
Uploading an artifact file
To upload an artifact file, first mint a JWT with mint_artifact_store_jwt, then POST the artifact to the artifact-store service. The payload must be base64-encoded.
Upload with an inline payload:
bash
curl -X POST "http://localhost:8000/artifact_store.ArtifactStoreService/UploadArtifact" \
  -H "Content-Type: application/json" \
  -H "X-Sphinx-Artifact-Store-JWT: $ARTIFACT_STORE_JWT" \
  -H "X-Sphinx-Version: 1.0.0" \
  --data '{
    "title": "example.txt",
    "payload": "SGVsbG8sIHdvcmxkIQ=="
  }'
Upload directly from a file (base64-encode first, then POST):
bash
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
The minted JWT is short-lived and scoped to the current MCP project and user, so mint it immediately before upload rather than caching it across a long session.
