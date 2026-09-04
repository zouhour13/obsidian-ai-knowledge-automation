# Data Contract

## AI Output

The AI analysis must return a single JSON object with the following fields:

| Field | Type | Required | Description |
|---|---|---|---|
| `summary` | string | Yes | Concise summary |
| `category` | string | Yes | Main knowledge category |
| `topics` | string[] | Yes | Main subjects |
| `key_concepts` | string[] | Yes | Important concepts |
| `actions` | string[] | Yes | Actionable tasks |
| `tags` | string[] | Yes | Obsidian-compatible tags |

## Example

```json
{
  "summary": "RAG combines retrieval with language model generation.",
  "category": "Artificial Intelligence",
  "topics": [
    "RAG",
    "Information Retrieval"
  ],
  "key_concepts": [
    "Embeddings",
    "Vector Database"
  ],
  "actions": [
    "Evaluate retrieval quality"
  ],
  "tags": [
    "#AI",
    "#RAG"
  ]
}
```

## Constraints

- Output must be valid JSON.
- No Markdown.
- No code fences.
- No additional top-level fields.
- `actions` may be an empty array.
- All tags must start with `#`.
- The model must not invent unsupported facts.
