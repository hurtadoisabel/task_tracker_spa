defmodule TaskTrackerSpa.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :timespent, :decimal
    field :title, :string
    field :userassigned, :string

    belongs_to :user, TaskTrackerSpa.Users.Users
    belongs_to :task, TaskTrackerSpa.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :userassigned, :timespent, :completed])
    |> validate_required([:title, :description, :userassigned, :timespent, :completed])
  end
end
