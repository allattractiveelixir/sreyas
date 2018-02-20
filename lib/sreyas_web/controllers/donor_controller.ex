defmodule SreyasWeb.DonorController do
  use SreyasWeb, :controller

  alias Sreyas.Donors
  alias Sreyas.Donors.Donor

  def index(conn, _params) do
    donors = Donors.list_donors()
    render(conn, "index.html", donors: donors)
  end

  def new(conn, _params) do
    changeset = Donors.change_donor(%Donor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"donor" => donor_params}) do
    case Donors.create_donor(donor_params) do
      {:ok, donor} ->
        conn
        |> put_flash(:info, "Donor created successfully.")
        |> redirect(to: donor_path(conn, :show, donor))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    donor = Donors.get_donor!(id)
    render(conn, "show.html", donor: donor)
  end

  def edit(conn, %{"id" => id}) do
    donor = Donors.get_donor!(id)
    changeset = Donors.change_donor(donor)
    render(conn, "edit.html", donor: donor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "donor" => donor_params}) do
    donor = Donors.get_donor!(id)

    case Donors.update_donor(donor, donor_params) do
      {:ok, donor} ->
        conn
        |> put_flash(:info, "Donor updated successfully.")
        |> redirect(to: donor_path(conn, :show, donor))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", donor: donor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    donor = Donors.get_donor!(id)
    {:ok, _donor} = Donors.delete_donor(donor)

    conn
    |> put_flash(:info, "Donor deleted successfully.")
    |> redirect(to: donor_path(conn, :index))
  end
end
