defmodule Sreyas.Repo.Migrations.CreateDonations do
  use Ecto.Migration

  def change do
    create table(:donations) do
      add :donor_id, :integer
      add :donation_program_id, :integer
      add :amount, :float
      add :payment_method, :string
      add :donation_notes, :text
      add :username, :string

      timestamps()
    end

  end
end
