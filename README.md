# ExTrelloNotifier

Create trello cards from errors using webhook

## TODO

- [x] ~implement trello card via rest api~
- [x] ~process webhook response body from error monitoring tools~
- [x] ~add trello label for cards resolved/unresolved~
- add Github project (kanban, automation)
- add Cachex for retrieving list id and labels
- verify webhook signature (security)
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
- update README file to contain instructions from Trello, error monitoring tool and sample deployment for Phoenix framework
- publish docs (hexdocs for Phoenix framework)
- add cd workflow (fly.io)

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Don't forget env variables (e.g. `export TRELLO_API_KEY=aaaa...`)
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

You can test the flow locally by:

1. Create a mix project: add error monitoring tool and install e.g. [`:rollbax`](https://github.com/ForzaElixir/rollbax) to trigger the error. **Note**: create a route and add the error as a trigger point.
2. Run `ex_trello_notifier` on another port (`PORT=4444 iex -S mix.phx server`).
3. Expose those two apps via tunneling. For this demo, use ngrok.io
4. Add auth token in `ngrok.yml`, then `ngrok start --config=ngrok.yml test notifier`.
5. `curl https://d4b2-175-176-95-4.ap.ngrok.io/PATH_IF_ANY`.
6. Then check Trello board for changes.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
