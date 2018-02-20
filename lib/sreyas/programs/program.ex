defmodule Sreyas.Programs.Program do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sreyas.Programs.Program


  schema "programs" do
    field :category, :string
    field :goal, :float
    field :preset_amount, :float
    field :seva_description, :string
    field :seva_details, :string
    field :seva_name, :string

    timestamps()
  end

  @doc false
  def changeset(%Program{} = program, attrs) do
    program
    |> cast(attrs, [:category, :seva_name, :seva_description, :seva_details, :goal, :preset_amount])
    |> validate_required([:category, :seva_name, :seva_description, :seva_details, :goal, :preset_amount])
  end
end
