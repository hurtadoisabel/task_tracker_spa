defmodule TaskTrackerSpa.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :text
      add :userassigned, :string
      add :timespent, :decimal
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

    create index(:tasks, [:userassigned], unique: true

  end
end
