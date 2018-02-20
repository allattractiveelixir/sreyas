defmodule Sreyas.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Sreyas.Users.User


  schema "users" do
    field :crypted_password, :string
    field :email, :string
    field :username, :string, unique: true
    field :access_privelege, :string
    field :password, :string, virtual: true
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :name, :email, :crypted_password, :password, :access_privelege])
    |> validate_required([:username, :name, :email, :password, :access_privelege])
    |> put_crypted_password()
  end

  def put_crypted_password (changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :crypted_password, Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end

end
