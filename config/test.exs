use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :task_tracker_spa, TaskTrackerSpaWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :task_tracker_spa, TaskTrackerSpa.Repo,
  username: "task_tracker_spa",
  password: "spaspa",
  database: "task_tracker_spa_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
