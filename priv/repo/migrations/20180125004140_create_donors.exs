defmodule Sreyas.Repo.Migrations.CreateDonors do
  use Ecto.Migration

  def change do
    create table(:donors) do
      add :name, :string
      add :spiritual_name, :string
      add :phone, :string
      add :address_1, :string
      add :address_2, :string
      add :city, :string
      add :state, :string
      add :zip, :string
      add :country, :string
      add :notes, :text
      add :username, :string

      timestamps()
    end

  end
end
