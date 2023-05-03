# Phoenix Nix Starter

The idea is to have a ready to go phoenix project setup with Nix, along with all the bells and whistles (`run` commands for common workflows, multi env config, etc.)

The existing phoenix project is generated using `mix phx.new` with Phoenix 1.7.2, but it is easy (execute `run clean.phx`) to rip out all the phoenix related files and start from scratch with a new `mix phx.new` command as needed.

## Features Todo

- Nix setup
- Credo and Dialyzer setup
- ElixirLS setup for VSCode
- Dockerfile setup (Easy deployment to Fly.io)
- Multi env config
- `run` commands for common workflows
- Github Actions setup for running tests (with nix cache support)
- Setup for spawning an IEX shell on production server

### Todos

- move to nix flakes
- run commands to be added
  - `run clean.phx` which will remove all phoenix related files. useful when theres a need to run `mix phx.new` from scratch (e.g. newer phoenix versions)
  - `run clean` which will clean dependencies, etc.
  - `run deps` which will install dependencies
  - `run test` which will run tests
  - `run deploy` which will deploy to fly.io
  - `run rename.phx --module NewModule --app NewApp` which will rename the phoenix project and OTP application.
