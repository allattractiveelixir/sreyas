defmodule SreyasWeb.DonationController do
  use SreyasWeb, :controller

  alias Sreyas.Donations
  alias Sreyas.Donations.Donation

  def index(conn, _params) do
    donations = Donations.list_donations()
    render(conn, "index.html", donations: donations)
  end

  def new(conn, _params) do
    changeset = Donations.change_donation(%Donation{})

    donation_program_list = Sreyas.Programs.list_programs |> Enum.map(&{&1.category<>": "<>&1.seva_name, &1.id})
    render(conn, "new.html", changeset: changeset, donation_program_list: donation_program_list)
  end

  def create(conn, %{"donation" => donation_params}) do
    case Donations.create_donation(donation_params) do
      {:ok, donation} ->
        conn
        |> put_flash(:info, "Donation created successfully.")
        |> redirect(to: donation_path(conn, :show, donation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    donation = Donations.get_donation!(id)
    render(conn, "show.html", donation: donation)
  end

  def edit(conn, %{"id" => id}) do
    donation = Donations.get_donation!(id)
    changeset = Donations.change_donation(donation)
    render(conn, "edit.html", donation: donation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "donation" => donation_params}) do
    donation = Donations.get_donation!(id)

    case Donations.update_donation(donation, donation_params) do
      {:ok, donation} ->
        conn
        |> put_flash(:info, "Donation updated successfully.")
        |> redirect(to: donation_path(conn, :show, donation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", donation: donation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    donation = Donations.get_donation!(id)
    {:ok, _donation} = Donations.delete_donation(donation)

    conn
    |> put_flash(:info, "Donation deleted successfully.")
    |> redirect(to: donation_path(conn, :index))
  end
end
