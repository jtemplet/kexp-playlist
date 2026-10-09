# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A small Ruby gem (`kexp-playlist`) that fetches plays from the KEXP public API (`https://api.kexp.org/v2/plays/`) and prints them as `Artist - Song`. It has no runtime dependencies beyond the Ruby standard library, and the repo has no tests, Gemfile, or linter config.

## Commands

```sh
# Run from the working tree without installing
ruby -Ilib bin/kexp-playlist -s "2023-05-03" -t

# Build and install the gem locally
gem build kexp-playlist.gemspec
gem install ./kexp-playlist-0.0.0.gem --user-install
```

CLI flags: `-s/--start DATE` (required; exits 1 if missing) and `-t/--time` (print each song's timestamp).

## Architecture

The flow is `bin/kexp-playlist` (OptionParser) -> `Kexp::Playlist::Query.call(options)` in `lib/kexp-playlist.rb` -> `Fetch` -> `Presenter`.

- `Fetch` (`lib/kexp/playlist/fetch.rb`) makes one HTTP GET and returns an array of `{artist:, song:, airdate:}` hashes. Plays with a nil `artist` (such as air breaks) are dropped.
- `Presenter` (`lib/kexp/playlist/presenter.rb`) prints the hashes. The API returns newest first (`ordering: "-airdate"`), so the presenter reverses the list to print oldest first.

## Things that are easy to miss

- **The gemspec lists files by hand** (`s.files` in `kexp-playlist.gemspec`). When you add a file under `lib/`, add it to that list, or the built gem will not include it. `bin/kexp-playlist` also depends on this: it requires `kexp-playlist`, which only resolves through `-Ilib` or an installed gem.
- **`Fetch` shifts the start time by +1 hour** (`Time.parse(start_time) + 1*60*60`) before it sends it as `airdate_after`. The presenter labels timestamps as `PDT`. Check this offset against the API before you change either one.
- **There is no pagination.** The request sends `limit: 250` and `offset: 0`, so a start date with more than 250 plays after it returns only the newest 250 of them.
- `Fetch#time_to_utc` is never called.
