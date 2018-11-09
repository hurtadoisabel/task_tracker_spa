defmodule TaskTrackerSpaWeb.TaskControllerTest do
  use TaskTrackerSpaWeb.ConnCase

  alias TaskTrackerSpa.Tasks
  alias TaskTrackerSpa.Tasks.Task

  @create_attrs %{
    completed: true,
     description: "some description", 
     timespent: "120.5", 
     title: "some title", 
     userassigned: "some userassigned"
  }
  @update_attrs %{
    completed: false, 
    description: "some updated description", 
    timespent: "456.7", 
    title: "some updated title", 
    userassigned: "some updated userassigned"
  }
  @invalid_attrs %{
    completed: nil, description: nil, timespent: nil, title: nil, userassigned: nil}

  def fixture(:task) do
    {:ok, task} = Tasks.create_task(@create_attrs)
    task
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end


  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get(conn, Routes.task_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "new task" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.task_path(conn, :new))
      assert json_response(conn, 200) =~ "New Task"
    end
  end

  describe "create task" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.task_path(conn, :create), task: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.task_path(conn, :show, id))

      assert %{
        "id" => id,
        "description" => "some desccription",
        "userassigned" => "some user",
        "completed" => false,
        "timespent" => "8.4"
      } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.task_path(conn, :create), task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "edit task" do
    setup [:create_task]

    test "renders form for editing chosen task", %{conn: conn, task: task} do
      conn = get(conn, Routes.task_path(conn, :edit, task))
      assert json_response(conn, 200) =~ "Edit Task"
    end
  end

  describe "update task" do
    setup [:create_task]

    test "redirects when data is valid", %{conn: conn, task: task} do
      conn = put(conn, Routes.task_path(conn, :update, task), task: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.task_path(conn, :show, id))
      assert %{
        "id" => id,
        "description" => "dome updated desc",
        "title" => "some updated title",
        "userassigned" => "some userassigned",
        "completed" => flase,
        "timespent" => "4.5"
      } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, task: task} do
      conn = put(conn, Routes.task_path(conn, :update, task), task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "deletes chosen task", %{conn: conn, task: task} do
      conn = delete(conn, Routes.task_path(conn, :delete, task))
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get(conn, Routes.task_path(conn, :show, task))
      end
    end
  end

  defp create_task(_) do
    task = fixture(:task)
    {:ok, task: task}
  end
end
