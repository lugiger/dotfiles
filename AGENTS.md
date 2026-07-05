# global agent instructions

- Never use the em dash "—". Use plain dash "-" instead.
- When writing commit messages, NEVER auto-add your agent name as co-author.
- Never manually modify CHANGELOG.md files or any files marked as auto-generated.
- When making technical decisions, prefer quality, simplicity, robustness, and long-term maintainability over development speed.
- When doing bug fixes, always start by reproducing the bug in an end-to-end setting as closely aligned with how an end user would experience it. This ensures you find the real problem so your fix will actually solve it.
- Apply high standards to engineering excellence: fix lint errors, test failures, and test flakiness when you see them, even if not directly related to the current task.
- Be picky about UI: if something looks off, fix it along the way.
- Prefer editing existing files over creating new ones.
- Don't add error handling, abstractions, or features beyond what the task requires.
- Default to writing no comments in code. Only add one when the WHY is non-obvious.
