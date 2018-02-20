defmodule SreyasWeb.ProgramController do
  use SreyasWeb, :controller

  alias Sreyas.Programs
  alias Sreyas.Programs.Program

  def index(conn, _params) do
    programs = Programs.list_programs()
    render(conn, "index.html", programs: programs)
  end

  def new(conn, _params) do
    changeset = Programs.change_program(%Program{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"program" => program_params}) do
    case Programs.create_program(program_params) do
      {:ok, program} ->
        conn
        |> put_flash(:info, "Program created successfully.")
        |> redirect(to: program_path(conn, :show, program))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    program = Programs.get_program!(id)
    render(conn, "show.html", program: program)
  end

  def edit(conn, %{"id" => id}) do
    program = Programs.get_program!(id)
    changeset = Programs.change_program(program)
    render(conn, "edit.html", program: program, changeset: changeset)
  end

  def update(conn, %{"id" => id, "program" => program_params}) do
    program = Programs.get_program!(id)

    case Programs.update_program(program, program_params) do
      {:ok, program} ->
        conn
        |> put_flash(:info, "Program updated successfully.")
        |> redirect(to: program_path(conn, :show, program))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", program: program, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    program = Programs.get_program!(id)
    {:ok, _program} = Programs.delete_program(program)

    conn
    |> put_flash(:info, "Program deleted successfully.")
    |> redirect(to: program_path(conn, :index))
  end
end
