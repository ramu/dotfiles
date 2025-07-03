# Pull Request feedback response instructions

Review and address the latest feedback comments for Pull Request #$ARGUMENT.

## Pre-work Validation

- Verify that Pull Request #$ARGUMENT exists and is accessible
- Check if you have the necessary permissions to make changes
- If the Pull Request number is invalid, prompt the user for the correct Pull Request number

## Review Process

1. **Fetch Pull Request details**: Get the current state of the Pull Request using `gh pr view $ARGUMENT`
2. **Identify feedback**: Parse comments to identify:
   - Unresolved review comments
   - Requested changes
   - Priority level (critical, important, minor)
3. **Prioritize**: Address critical issues first, then important, then minor

## Implementation Guidelines

- **Commit messages**: Include the Pull Request number in commit messages (format: "fix: description (#$ARGUMENT)")
- **Code changes**: Follow existing code style and conventions
- **Testing**: Run relevant tests after making changes
- **Documentation**: Update documentation if changes affect public APIs

## Completion Checklist

- [ ] All feedback comments addressed
- [ ] Tests passing
- [ ] Code follows project conventions
- [ ] Commit messages include the Pull Request numbers
- [ ] Summary comment posted to Pull Request with changes made

## Error Handling

- If Pull Request is closed or merged, inform the user and ask for confirmation
- If access is denied, provide instructions for authentication
- If multiple unrelated feedback items exist, ask the user to prioritize

## Post-completion

After addressing all feedback, post a summary comment to the Pull Request describing:
- What issues were addressed
- What changes were made
- Any remaining items that need clarification
