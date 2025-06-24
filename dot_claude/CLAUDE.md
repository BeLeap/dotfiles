# Coding Method

I prefer TDD style.
Write test first and confirm the test fails.
Then implement it.

# Git Commit Guidelines

## IMPORTANT: Always make commits when making code changes
- You MUST commit your changes after completing meaningful work
- Always use `git add` and `git commit` commands
- Never leave uncommitted changes unless explicitly told otherwise
- Make commits even for small changes or fixes

## Incremental Development with Fixup Commits
- For large features or complex changes, use incremental fixup commits during development
- Start with an initial commit for the feature foundation
- Use `git commit --fixup=<commit-hash>` for subsequent improvements to the same feature
- This allows tracking development progress while keeping history clean
- At the end of development, use `git rebase -i --autosquash` to combine fixup commits

### Fixup Commit Workflow
1. Make initial commit: `git commit -m "feat: add user authentication system"`
2. Make improvements: `git commit --fixup=<initial-commit-hash> -m "add input validation"`
3. Add more features: `git commit --fixup=<initial-commit-hash> -m "implement password hashing"`
4. Fix issues: `git commit --fixup=<initial-commit-hash> -m "fix edge case in validation"`
5. Final cleanup: `git rebase -i --autosquash HEAD~4` (adjust number as needed)

### When to Use Fixup Commits
- Multi-step feature implementation
- Iterative bug fixing
- Code review feedback incorporation
- Refactoring large code sections
- Adding tests after initial implementation

## Commit Strategy
- Break down work into logical, meaningful units for commits
- Each commit should contain one complete feature or fix
- Never commit code that doesn't compile or fails tests
- Aim for atomic commits that can stand alone

## Commit Unit Criteria
Create separate commits for:
- New feature implementations
- Bug fixes
- Code refactoring
- Configuration changes
- Documentation updates
- Dependency changes
- Test additions/modifications
- Performance improvements

## Commit Message Format
```
<type>: <brief description>

<detailed explanation (optional)>
```

### Commit Types
- `feat`: New feature addition
- `fix`: Bug fix
- `refactor`: Code refactoring without functionality changes
- `style`: Code style changes (formatting, whitespace, etc.)
- `docs`: Documentation changes
- `test`: Test additions or modifications
- `chore`: Build tasks, package manager configs, etc.
- `perf`: Performance improvements

## Good Commit Examples
- `feat: add user authentication system`
- `fix: resolve session timeout issue on login`
- `refactor: improve database connection handling`
- `docs: update API documentation for v2.0`
- `test: add unit tests for payment processing`

## Pre-commit Checklist
1. Does the code compile and run without errors?
2. Do all tests pass?
3. Is the commit message clear and descriptive?
4. Are unrelated changes excluded from this commit?
5. Have I reviewed the diff before committing?

## Additional Guidelines
- Keep commits focused on a single concern
- Write commit messages in imperative mood ("add" not "added")
- Use present tense in commit messages
- Avoid committing large binary files or temporary files
- Consider using fixup commits during development, then squash before final push
- Commit early and often during development
- Use meaningful branch names that reflect the work being done
- Always create fixup commits for incremental progress on the same logical unit of work

## What NOT to Commit
- Temporary/debug files
- IDE-specific configuration files
- Compiled binaries (unless necessary)
- Sensitive information (passwords, API keys)
- Large datasets or media files (use Git LFS if needed)

## Code Review Preparation
- Ensure each commit tells a clear story
- Group related changes together
- Separate formatting changes from logic changes
- Make sure commit history is clean and readable
