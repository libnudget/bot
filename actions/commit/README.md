# libnudget bot commit action

Reusable GitHub Action to commit changes as **libnudget[bot]**.

## Usage

```yaml
- uses: libnudget/bot/actions/commit@v1
  with:
    message: "chore(deps): update lockfile"
```

## Guarantees

* Consistent bot identity
* Custom avatar
* Clean commit history
