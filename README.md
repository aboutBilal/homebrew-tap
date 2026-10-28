# Homebrew tap for Spillkit

```bash
brew install aboutbilal/tap/spillkit
leak doctor     # checks this machine
leak demo       # see it work in a minute, on a leak made for the purpose
```

[Spillkit](https://github.com/aboutBilal/spillkit) is the emergency kit for leaked secrets. It finds every secret in your Git history, tells you which to rotate first and walks you through it, tracks down copies that survive deletion, and writes the incident report. The formula installs the `leak` command with the tools it needs: bash 4.4 or later (macOS ships 3.2), gitleaks and jq. It works on macOS and Linux.

Upgrade with `brew upgrade spillkit`. Report problems and ask questions in the [Spillkit repository](https://github.com/aboutBilal/spillkit/issues), not here.

## How the formula stays current

Once a day, [a workflow](.github/workflows/update.yml) checks for a new Spillkit release. Before it changes the formula, it verifies two things about the release archive:

- its SHA-256 checksum;
- its Sigstore signature, which must come from Spillkit's own release workflow for that exact tag.

It then installs and tests the formula, and only then commits the update. Every change to this tap is also [tested](.github/workflows/tests.yml) on macOS and Linux with `brew install`, `brew test` and `brew audit --strict`.

## License

[MIT](LICENSE), like Spillkit.
