defmodule Sreyas.Donations.Donation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sreyas.Donations.Donation


  schema "donations" do
    field :amount, :float
    field :donation_notes, :string
    field :donation_program_id, :integer
    field :donor_id, :integer
    field :payment_method, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%Donation{} = donation, attrs) do
    donation
    |> cast(attrs, [:donor_id, :donation_program_id, :amount, :payment_method, :donation_notes, :username])
    |> validate_required([:donor_id, :donation_program_id, :amount, :payment_method, :donation_notes, :username])
  end
end
