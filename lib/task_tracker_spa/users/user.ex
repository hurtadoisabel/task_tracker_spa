defmodule TaskTrackerSpa.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :password_hash, :string

    has_many :tasks, TaskTrackerSpa.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password_hash])
    |> unique_constraint(:email)
    |> validate_required([:email, :password_hash])
  end
end
