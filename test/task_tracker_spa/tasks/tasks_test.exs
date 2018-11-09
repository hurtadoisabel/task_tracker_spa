defmodule TaskTrackerSpa.TasksTest do
  use TaskTrackerSpa.DataCase

  alias TaskTrackerSpa.Tasks

  describe "tasks" do
    alias TaskTrackerSpa.Tasks.Task

    @valid_attrs %{completed: true, description: "some description", timespent: "120.5", title: "some title", userassigned: "some userassigned"}
    @update_attrs %{completed: false, description: "some updated description", timespent: "456.7", title: "some updated title", userassigned: "some updated userassigned"}
    @invalid_attrs %{completed: nil, description: nil, timespent: nil, title: nil, userassigned: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tasks.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Tasks.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tasks.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Tasks.create_task(@valid_attrs)
      assert task.completed == true
      assert task.description == "some description"
      assert task.timespent == Decimal.new("120.5")
      assert task.title == "some title"
      assert task.userassigned == "some userassigned"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Tasks.update_task(task, @update_attrs)

      
      assert task.completed == false
      assert task.description == "some updated description"
      assert task.timespent == Decimal.new("456.7")
      assert task.title == "some updated title"
      assert task.userassigned == "some updated userassigned"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task == Tasks.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end
end
