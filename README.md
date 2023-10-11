# KeycloakTestappEx

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Deployment

What is used here is two herokuish buildpacks, as specified in `.buildpacks`.

The static buildpack assumes a `package.json` in `assets/`, and fails without it. So we put a placeholder package file there, even though we don't install anything.

Also, the `compile` script is overridden, as the latest phoenix has a `mix assets.deploy` command, and the static buildpack assumes `mix phx.digest`.
