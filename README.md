Lix-Starter is a batteries-included repo to kick start any Elixir/Vue project from.

It includes:

- One Elixir OTP application (A1) for core logic (only contains one module)
  - The app is configured with adequate development dependencies
- An Phoenix interface application (A2) that includes A1 as a dependency
- Channel setup to be used with phoenix.js from a Vue application
- Basic Vue application (configurable with vue ui or cli) that can interface with backend through Phoenix channel
- Bulma setup of CSS template
- Instantly deployable to gigalixir

Options that are not included

- Prepared option of vault as external auth provider
- Prepared option to integrate blockchain platforms like Waves
- Prepared option to integrate PostgreSQL setup (useable via Gigalixir)
- Prepared option to integrate GraphQL

Design problems:

- templating (Vue Single file Components)
- free wheeling (Bulma)

to add:

- bulma
- cypress.js
- ecto
- cordova
- elixir unit and doc tests
- elixir property tests
