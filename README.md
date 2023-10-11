# KeycloakTestappEx

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Deployment

What is used here is two herokuish buildpacks, as specified in `.buildpacks`.

There were two problems, resulting from the changes in the most recent Phoenix app structure (probably since 1.7), which don't work with the assumptions the static buildpack makes. (1.7 introduces an `esbuild` where it was `brunch` before, and it assumes `mix assets.deploy` to be used for building assets, which didn't exist by default before.)

The buildpack assumes a `package.json` in `assets/`, and fails without it. So we put a placeholder package file there, even though we don't install anything.

Also, the latest phoenix has a `mix assets.deploy` command, and the static buildpack assumes `mix phx.digest`. This is solved by overriding the `compile` script is overridden (placed at `$PROJECT_ROOT/compile`).
