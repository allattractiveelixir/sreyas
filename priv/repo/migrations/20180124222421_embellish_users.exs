defmodule Sreyas.Repo.Migrations.EmbellishUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :username, :string, unique: true
      add :access_privelege, :string
    end
    create unique_index(:users, [:username])
  end
end
