# experimental-engineer

> A Claude Code subagent that explores **unconventional, first-principles solutions** to hard technical problems. Channels John Carmack-style fearless engineering.

When standard optimizations aren't cutting it, when the architecture feels fundamentally wrong, or when a feature is "working" but the code is a mess — this subagent is given explicit permission to question every assumption and propose radical rewrites, novel data structures, and bleeding-edge approaches.

## What it does

Most coding agents play it safe. They suggest the obvious, well-trodden fix. `experimental-engineer` is the opposite: a subagent prompted to act like a senior performance engineer who has been told *"go ham — propose the crazy thing."*

It will:

- **Question every assumption** — "Why does this layer exist at all?"
- **Generate 2–3 radically different approaches**, from conservative to wild
- **Provide working code**, not pseudocode, with concrete trade-offs
- **Reach for unusual tools** — WASM, Web Workers, GPU compute, ropes, persistent data structures, spatial indexes, compile-time codegen, event sourcing
- **Be honest about risk** — it knows when *not* to use clever solutions

## When to invoke it

- A performance bottleneck where standard optimizations have failed
- An architecture that feels fundamentally wrong but you can't articulate why
- A subsystem that's accreted complexity and needs a rethink, not a refactor
- You've shipped something that works but the approach feels clunky and you want to explore alternatives

Claude Code's main agent will automatically delegate to it when these patterns appear in your conversation.

## Installation

### Claude Code (recommended)

Add this repository as a plugin marketplace, then install:

```bash
/plugin marketplace add codyhxyz/experimental-engineer
/plugin install experimental-engineer@experimental-engineer
```

### Manual install

Drop the agent file into your user agents directory:

```bash
mkdir -p ~/.claude/agents
curl -fsSL https://raw.githubusercontent.com/codyhxyz/experimental-engineer/main/agents/experimental-engineer.md \
  -o ~/.claude/agents/experimental-engineer.md
```

Restart Claude Code and the agent will appear in the `Task` tool's `subagent_type` options.

## Usage

Once installed, Claude Code will recommend `experimental-engineer` automatically when your request matches its triggers. You can also invoke it explicitly:

> "Use the experimental-engineer agent to rethink how our sync queue works."

> "Spawn experimental-engineer to find a wilder approach to this rendering bottleneck."

## Examples

> **Example 1:** "Our tree view is lagging with 10k+ nodes. Standard virtualization isn't cutting it." — The agent returns three approaches ordered conservative → wild: (1) move layout to a Web Worker to kill main-thread jank, (2) replace the recursive tree with a flat indexed array + parent pointers for cache-friendly traversal (~10× faster), (3) render the entire tree to a GPU-accelerated `<canvas>` (1M nodes at 60fps). Each comes with trade-offs and a pick-#2 recommendation for highest leverage × lowest blast radius.

> **Example 2:** "Our sync queue keeps growing more complex. Maybe there's a completely different way?" — The agent challenges the queue's existence: (1) event sourcing with a CRDT — the "queue" becomes an append-only log, conflicts resolve mathematically, you delete ~80% of reconciliation code; (2) operation-based sync over a single WebSocket subscription — server is the source of truth, clients are projections, real-time becomes a side effect. Honest about the rewrite cost and helps pick based on whether offline-first or real-time matters more.

## Design philosophy

This agent exists because most LLM-driven engineering converges on the same safe, mediocre answer. Inversely-prompting an agent to propose the *unsafe, immoderate* answer surfaces options you'd never have considered — even if you don't ship them, they recalibrate your sense of what's possible.

It's not for every task. Use the standard agents for bug fixes and small features. Use this one when you've already tried the obvious thing and it didn't work.

## Contributing

Issues and pull requests welcome. If you have a great example of `experimental-engineer` solving a real problem, open an issue and I'll add it to this README.

## License

[MIT](LICENSE) © 2026 Cody Hergenroeder
