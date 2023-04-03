# Notifier

## TODO

- [x] ~implement trello card via rest api~
- [x] ~process sentry webhook response body~
- [x] ~add trello label for cards resolved/unresolved~
- add Github project (kanban, automation)
- add Cachex for retrieving list id and labels
- verify Sentry webhook signature (security)
- add code docs (typespecs, docs/moduledocs)
- use markdown for creating card description (TBA)
- add Credo (code linter)
- add Sobelow (security checker for framework)
- add Honeybadger (error monitoring)
- add Uptimerobot (uptime monitoring)
- add Logflare (log aggregator)
- add ci workflow (unit, mocks)
- add code coverage (deps, ci)
- add badge (ci, coverage, dependabot, etc.)
- add semver
- update README file to contain instructions from Trello, Sentry and sample deployment for Phoenix framework
- publish docs (hexdocs for Phoenix framework)
- add cd workflow (fly.io)

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Don't forget env variables (e.g. `export TRELLO_API_KEY=aaaa...`)
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
