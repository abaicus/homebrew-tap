# abaicus/homebrew-tap

Homebrew casks for my apps.

```sh
brew install --cask abaicus/tap/claude-pet
```

(`brew tap abaicus/tap` first is optional — installing by the full name taps it
for you.)

## Casks

| Cask | What it is |
| --- | --- |
| [`claude-pet`](Casks/claude-pet.rb) | A desktop tamagotchi that feeds on Claude Code activity — [source](https://github.com/abaicus/claude-pet) |

## How the casks get updated

Nobody edits `Casks/*.rb` by hand. Each app's release workflow renders its own
cask, ships it as a release asset, and this tap receives it two ways: pushed
directly on release, and pulled hourly by
[`update-cask.yml`](.github/workflows/update-cask.yml) as a fallback. Both
copy the same file, so a broken token costs an hour, not a release.
