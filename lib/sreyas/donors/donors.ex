defmodule Sreyas.Donors do
  @moduledoc """
  The Donors context.
  """

  import Ecto.Query, warn: false
  alias Sreyas.Repo

  alias Sreyas.Donors.Donor

  @doc """
  Returns the list of donors.

  ## Examples

      iex> list_donors()
      [%Donor{}, ...]

  """
  def list_donors do
    Repo.all(Donor)
  end

  @doc """
  Gets a single donor.

  Raises `Ecto.NoResultsError` if the Donor does not exist.

  ## Examples

      iex> get_donor!(123)
      %Donor{}

      iex> get_donor!(456)
      ** (Ecto.NoResultsError)

  """
  def get_donor!(id), do: Repo.get!(Donor, id)

  @doc """
  Creates a donor.

  ## Examples

      iex> create_donor(%{field: value})
      {:ok, %Donor{}}

      iex> create_donor(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_donor(attrs \\ %{}) do
    %Donor{}
    |> Donor.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a donor.

  ## Examples

      iex> update_donor(donor, %{field: new_value})
      {:ok, %Donor{}}

      iex> update_donor(donor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_donor(%Donor{} = donor, attrs) do
    donor
    |> Donor.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Donor.

  ## Examples

      iex> delete_donor(donor)
      {:ok, %Donor{}}

      iex> delete_donor(donor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_donor(%Donor{} = donor) do
    Repo.delete(donor)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking donor changes.

  ## Examples

      iex> change_donor(donor)
      %Ecto.Changeset{source: %Donor{}}

  """
  def change_donor(%Donor{} = donor) do
    Donor.changeset(donor, %{})
  end
end
