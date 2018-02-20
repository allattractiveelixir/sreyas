defmodule Sreyas.ProgramsTest do
  use Sreyas.DataCase

  alias Sreyas.Programs

  describe "programs" do
    alias Sreyas.Programs.Program

    @valid_attrs %{category: "some category", goal: 120.5, preset_amount: 120.5, seva_description: "some seva_description", seva_details: "some seva_details", seva_name: "some seva_name"}
    @update_attrs %{category: "some updated category", goal: 456.7, preset_amount: 456.7, seva_description: "some updated seva_description", seva_details: "some updated seva_details", seva_name: "some updated seva_name"}
    @invalid_attrs %{category: nil, goal: nil, preset_amount: nil, seva_description: nil, seva_details: nil, seva_name: nil}

    def program_fixture(attrs \\ %{}) do
      {:ok, program} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Programs.create_program()

      program
    end

    test "list_programs/0 returns all programs" do
      program = program_fixture()
      assert Programs.list_programs() == [program]
    end

    test "get_program!/1 returns the program with given id" do
      program = program_fixture()
      assert Programs.get_program!(program.id) == program
    end

    test "create_program/1 with valid data creates a program" do
      assert {:ok, %Program{} = program} = Programs.create_program(@valid_attrs)
      assert program.category == "some category"
      assert program.goal == 120.5
      assert program.preset_amount == 120.5
      assert program.seva_description == "some seva_description"
      assert program.seva_details == "some seva_details"
      assert program.seva_name == "some seva_name"
    end

    test "create_program/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Programs.create_program(@invalid_attrs)
    end

    test "update_program/2 with valid data updates the program" do
      program = program_fixture()
      assert {:ok, program} = Programs.update_program(program, @update_attrs)
      assert %Program{} = program
      assert program.category == "some updated category"
      assert program.goal == 456.7
      assert program.preset_amount == 456.7
      assert program.seva_description == "some updated seva_description"
      assert program.seva_details == "some updated seva_details"
      assert program.seva_name == "some updated seva_name"
    end

    test "update_program/2 with invalid data returns error changeset" do
      program = program_fixture()
      assert {:error, %Ecto.Changeset{}} = Programs.update_program(program, @invalid_attrs)
      assert program == Programs.get_program!(program.id)
    end

    test "delete_program/1 deletes the program" do
      program = program_fixture()
      assert {:ok, %Program{}} = Programs.delete_program(program)
      assert_raise Ecto.NoResultsError, fn -> Programs.get_program!(program.id) end
    end

    test "change_program/1 returns a program changeset" do
      program = program_fixture()
      assert %Ecto.Changeset{} = Programs.change_program(program)
    end
  end
end
