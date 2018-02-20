defmodule Sreyas.Donors.Donor do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sreyas.Donors.Donor


  schema "donors" do
    field :address_1, :string
    field :address_2, :string
    field :city, :string
    field :country, :string
    field :name, :string
    field :notes, :string
    field :phone, :string
    field :spiritual_name, :string
    field :state, :string
    field :username, :string
    field :zip, :string

    timestamps()
  end

  @doc false
  def changeset(%Donor{} = donor, attrs) do
    donor
    |> cast(attrs, [:name, :spiritual_name, :phone, :address_1, :address_2, :city, :state, :zip, :country, :notes, :username])
    |> validate_required([:name, :spiritual_name, :phone, :address_1, :address_2, :city, :state, :zip, :country, :notes, :username])
  end
end
