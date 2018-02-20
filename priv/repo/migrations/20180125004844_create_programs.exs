defmodule Sreyas.Repo.Migrations.CreatePrograms do
  use Ecto.Migration

  def change do
    create table(:programs) do
      add :category, :string
      add :seva_name, :string
      add :seva_description, :string
      add :seva_details, :text
      add :goal, :float
      add :preset_amount, :float

      timestamps()
    end

  end
end
