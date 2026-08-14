# abaicus/homebrew-tap

Homebrew casks for my apps.

```sh
brew install --cask abaicus/tap/gogu
```

(`brew tap abaicus/tap` first is optional — installing by the full name taps it
for you.)

## Casks

| Cask | What it is |
| --- | --- |
| `gogu` | A desktop tamagotchi that feeds on Claude Code activity — [source](https://github.com/abaicus/gogu) |

## How the casks get updated

Nobody edits `Casks/*.rb` by hand. Each app's release workflow renders its own
cask, ships it as a release asset, and this tap receives it two ways: pushed
directly on release, and pulled hourly by
[`update-cask.yml`](.github/workflows/update-cask.yml) as a fallback. Both
copy the same file, so a broken token costs an hour, not a release.

## The claude-pet → gogu rename

Gogu was called `claude-pet` up to v0.1.0, and `Casks/claude-pet.rb` is still
what this tap serves — a cask has to point at a real build, and the v0.1.0
assets are the ones that were built under the old name.

The switch happens on its own with the next release: `update-cask.yml` copies
the new `gogu.rb`, and only once that file is really here does it delete
`Casks/claude-pet.rb` and write a `tap_migrations.json` that moves anyone still
on the old token across. Nothing to do by hand.
