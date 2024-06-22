# Phoenix Nix Starter

The idea is to have a ready to go phoenix project setup with Nix, along with some extra bells and whistles (see [Features](#features)).

The existing phoenix project is generated using `mix phx.new` with Phoenix 1.7.14, but it is easy (execute `run delete.phx`) to rip out all the phoenix related files and start from scratch with a new `mix phx.new` command as needed.

## Features

- Nix setup (using flakes)
- Postgres & pgadmin setup (via Docker Compose)
- Credo and Dialyzer setup
- Livebook attached to the Phoenix app
- Multi env support (using [shdotenv](https://github.com/ko1nksm/shdotenv))
- `run` commands for common workflows
- Github Actions setup for
  - running build & tests in CI (with nix cache & postgres support)
  - running lint (credo) and dialyzer in CI
  - deploying to fly.io via gh actions or via terminal (currently setup to deploy on manual trigger)
- VSCode Tasks for running tests.

## Setting Up

- Installing nix and direnv is required.
- Clone this repo and `cd` into it.
- Execute `direnv allow` in the terminal.
- Execute `help` in the terminal to see the available commands.
- Execute `run deps` in the terminal to install dependencies.
- To customize this for your Phoenix project, you have two options:
  1. Rename and use the existing Phoenix project (Phoenix 1.7.2)
  2. Remove existing Phoenix project, and generate a new one

### 1. Rename and use the existing Phoenix project

- Execute `rename_phoenix_project MODULE=NewName APP=new_otp` which will rename the phoenix project and OTP application to `NewName` and `new_otp` respectively.

### 2. Remove existing Phoenix project, and generate a new one

- If you want to generate your own phoenix project instead of using the existing one, you can do so by executing `run delete.phx` in the terminal.
- This will remove all the phoenix related files and directories, and you can generate your own phoenix project using [`mix phx.new`](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html).
- Note that this will also remove `credo` and `dialyxir` from deps. To add it back, just add the following in `deps` of `mix.exs`:

```elixir
      # Linting
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
```

## List of available commands

Following info can also be found by executing `help` in the terminal

- `help` Show help message with available commands
- `run [command]` Run any command with dev env loaded
- `run deps` Install dependencies
- `run server` Run the server inside an IEx shell
- `run server.iex` Run a remote IEx shell connected to the server. useful for debugging in IEX without logs getting in the way.
- `run livebook.setup` Setup livebook
- `run livebook` Run livebook
- `run compile` Compile the project
- `run db` Start postgres and pgadmin
- `run db.setup` Setup local db
- `run db.migrate` Migrate local db
- `run db.rollback` Rollback local db
- `run db.create_migration <name>` Create new migration script
- `run dev.reset` Reset dev database
- `run test.reset` Reset test database
- `run test` Run tests
- `run test.watch` Run test in watch mode
- `run test.cover` Show test coverage
- `run format` Format project files
- `run lint` Lint project files
- `run delete.phx` Remove all Phoenix framework related files
- `run clean` Removes dependencies, build files, and ElixirLS files

### Todos

- run commands to be added
  - `run deploy` which will deploy to fly.io
  - document lint setup, and remaining `run` commands.
- Setup for spawning an IEX shell on production server
- Document env setup (.env.dev in dev environtment, .env.test in test environment, .local files to override them)

### Deploying to fly

**Option 1: via terminal**

- `flake.nix` has `flyctl`.
- `flyctl auth login`
- `fly launch`

**Option 2: via GH Actions**

- todo: add docs
