# Phoenix Nix Starter

The idea is to have a ready to go phoenix project setup with Nix, along with some extra bells and whistles (see [Features](#features)).

The existing phoenix project is generated using `mix phx.new` with Phoenix 1.7.2, but it is easy (execute `run delete.phx`) to rip out all the phoenix related files and start from scratch with a new `mix phx.new` command as needed.

## Features Todo

- Nix setup
- Credo and Dialyzer setup
- Dockerfile setup (Easy deployment to Fly.io)
- Multi env support (using [shdotenv](https://github.com/ko1nksm/shdotenv))
- `run` commands for common workflows
- Github Actions setup for
  - running tests (with nix cache support)
  - deploying to fly.io
- Setup for spawning an IEX shell on production server
- VSCode Tasks for running tests.

## Setting Up

- Installing nix and direnv is required.
- Clone this repo and `cd` into it.
- Execute `run init` in the terminal.
- Execute `help` in the terminal to see the available commands.
- Execute `run deps` in the terminal to install dependencies.

## Clean Existing Phoenix Project

- If you want to generate your own phoenix project instead of using the existing one, you can do so by executing `run delete.phx` in the terminal.
- This will remove all the phoenix related files and directories, and you can generate your own phoenix project using [`mix phx.new`](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html).

## List of available commands

Following info can also be found by executing `help` in the terminal

`help` Show help message with available commands
`run [command]` Run any command with dev env loaded
`run deps` Install dependencies
`run dev.reset` Reset dev database
`run db.setup` Setup local db
`run db.migrate` Migrate local db
`run db.rollback` Rollback local db
`run db.create_migration <name>` Create new migration script
`run server` Run the server inside an IEx shell
`run test.reset` Reset test database
`run test` Run tests
`run test.watch` Run test in watch mode
`run test.cover` Show test coverage
`run format` Format project files
`run lint` Lint project files
`run delete.phx` Remove all Phoenix framework related files
`run clean` Removes dependencies, build files, and ElixirLS files

### Todos

- move to nix flakes
- run commands to be added
  - `run clean` which will clean dependencies, etc.
  - `run deps` which will install dependencies
  - `run test` which will run tests
  - `run deploy` which will deploy to fly.io
  - `run rename.phx --module NewModule --app NewApp` which will rename the phoenix project and OTP application.
