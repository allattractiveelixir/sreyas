defmodule SreyasWeb.DonationControllerTest do
  use SreyasWeb.ConnCase

  alias Sreyas.Donations

  @create_attrs %{amount: 120.5, donation_notes: "some donation_notes", donation_program_id: 42, donor_id: 42, payment_method: "some payment_method", username: "some username"}
  @update_attrs %{amount: 456.7, donation_notes: "some updated donation_notes", donation_program_id: 43, donor_id: 43, payment_method: "some updated payment_method", username: "some updated username"}
  @invalid_attrs %{amount: nil, donation_notes: nil, donation_program_id: nil, donor_id: nil, payment_method: nil, username: nil}

  def fixture(:donation) do
    {:ok, donation} = Donations.create_donation(@create_attrs)
    donation
  end

  describe "index" do
    test "lists all donations", %{conn: conn} do
      conn = get conn, donation_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Donations"
    end
  end

  describe "new donation" do
    test "renders form", %{conn: conn} do
      conn = get conn, donation_path(conn, :new)
      assert html_response(conn, 200) =~ "New Donation"
    end
  end

  describe "create donation" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, donation_path(conn, :create), donation: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == donation_path(conn, :show, id)

      conn = get conn, donation_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Donation"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, donation_path(conn, :create), donation: @invalid_attrs
      assert html_response(conn, 200) =~ "New Donation"
    end
  end

  describe "edit donation" do
    setup [:create_donation]

    test "renders form for editing chosen donation", %{conn: conn, donation: donation} do
      conn = get conn, donation_path(conn, :edit, donation)
      assert html_response(conn, 200) =~ "Edit Donation"
    end
  end

  describe "update donation" do
    setup [:create_donation]

    test "redirects when data is valid", %{conn: conn, donation: donation} do
      conn = put conn, donation_path(conn, :update, donation), donation: @update_attrs
      assert redirected_to(conn) == donation_path(conn, :show, donation)

      conn = get conn, donation_path(conn, :show, donation)
      assert html_response(conn, 200) =~ "some updated donation_notes"
    end

    test "renders errors when data is invalid", %{conn: conn, donation: donation} do
      conn = put conn, donation_path(conn, :update, donation), donation: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Donation"
    end
  end

  describe "delete donation" do
    setup [:create_donation]

    test "deletes chosen donation", %{conn: conn, donation: donation} do
      conn = delete conn, donation_path(conn, :delete, donation)
      assert redirected_to(conn) == donation_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, donation_path(conn, :show, donation)
      end
    end
  end

  defp create_donation(_) do
    donation = fixture(:donation)
    {:ok, donation: donation}
  end
end
