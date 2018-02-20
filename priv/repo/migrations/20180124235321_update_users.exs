defmodule Sreyas.Repo.Migrations.UpdateUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :name, :string
    end
  end
end
