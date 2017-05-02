# Release Steps
  * Fresh clone or clean this repo.
  * Make sure to bump version if not done already.
  * Set up environment.
    ``` bash
    # Set up mix environment.
    export MIX_ENV=prod
    # Generate the make file.
    elixir scripts/generate_makefile.exs
    ```
  * Execute the build. `make release` This will take a long time.
  * Upload the contents of `latest-release` to GitHub releases.
