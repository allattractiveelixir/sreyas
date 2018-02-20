defmodule SreyasWeb.ProgramControllerTest do
  use SreyasWeb.ConnCase

  alias Sreyas.Programs

  @create_attrs %{category: "some category", goal: 120.5, preset_amount: 120.5, seva_description: "some seva_description", seva_details: "some seva_details", seva_name: "some seva_name"}
  @update_attrs %{category: "some updated category", goal: 456.7, preset_amount: 456.7, seva_description: "some updated seva_description", seva_details: "some updated seva_details", seva_name: "some updated seva_name"}
  @invalid_attrs %{category: nil, goal: nil, preset_amount: nil, seva_description: nil, seva_details: nil, seva_name: nil}

  def fixture(:program) do
    {:ok, program} = Programs.create_program(@create_attrs)
    program
  end

  describe "index" do
    test "lists all programs", %{conn: conn} do
      conn = get conn, program_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Programs"
    end
  end

  describe "new program" do
    test "renders form", %{conn: conn} do
      conn = get conn, program_path(conn, :new)
      assert html_response(conn, 200) =~ "New Program"
    end
  end

  describe "create program" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, program_path(conn, :create), program: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == program_path(conn, :show, id)

      conn = get conn, program_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Program"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, program_path(conn, :create), program: @invalid_attrs
      assert html_response(conn, 200) =~ "New Program"
    end
  end

  describe "edit program" do
    setup [:create_program]

    test "renders form for editing chosen program", %{conn: conn, program: program} do
      conn = get conn, program_path(conn, :edit, program)
      assert html_response(conn, 200) =~ "Edit Program"
    end
  end

  describe "update program" do
    setup [:create_program]

    test "redirects when data is valid", %{conn: conn, program: program} do
      conn = put conn, program_path(conn, :update, program), program: @update_attrs
      assert redirected_to(conn) == program_path(conn, :show, program)

      conn = get conn, program_path(conn, :show, program)
      assert html_response(conn, 200) =~ "some updated category"
    end

    test "renders errors when data is invalid", %{conn: conn, program: program} do
      conn = put conn, program_path(conn, :update, program), program: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Program"
    end
  end

  describe "delete program" do
    setup [:create_program]

    test "deletes chosen program", %{conn: conn, program: program} do
      conn = delete conn, program_path(conn, :delete, program)
      assert redirected_to(conn) == program_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, program_path(conn, :show, program)
      end
    end
  end

  defp create_program(_) do
    program = fixture(:program)
    {:ok, program: program}
  end
end
