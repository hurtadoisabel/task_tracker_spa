defmodule TaskTrackerSpa.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :admin, :boolean, default: false, null: false
      add :password_hash, :string

      timestamps()
    end

    create index(:users, [:email], unique: true)
  end
end
