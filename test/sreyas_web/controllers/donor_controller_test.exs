defmodule SreyasWeb.DonorControllerTest do
  use SreyasWeb.ConnCase

  alias Sreyas.Donors

  @create_attrs %{address_1: "some address_1", address_2: "some address_2", city: "some city", country: "some country", name: "some name", notes: "some notes", phone: "some phone", spiritual_name: "some spiritual_name", state: "some state", username: "some username", zip: "some zip"}
  @update_attrs %{address_1: "some updated address_1", address_2: "some updated address_2", city: "some updated city", country: "some updated country", name: "some updated name", notes: "some updated notes", phone: "some updated phone", spiritual_name: "some updated spiritual_name", state: "some updated state", username: "some updated username", zip: "some updated zip"}
  @invalid_attrs %{address_1: nil, address_2: nil, city: nil, country: nil, name: nil, notes: nil, phone: nil, spiritual_name: nil, state: nil, username: nil, zip: nil}

  def fixture(:donor) do
    {:ok, donor} = Donors.create_donor(@create_attrs)
    donor
  end

  describe "index" do
    test "lists all donors", %{conn: conn} do
      conn = get conn, donor_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Donors"
    end
  end

  describe "new donor" do
    test "renders form", %{conn: conn} do
      conn = get conn, donor_path(conn, :new)
      assert html_response(conn, 200) =~ "New Donor"
    end
  end

  describe "create donor" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, donor_path(conn, :create), donor: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == donor_path(conn, :show, id)

      conn = get conn, donor_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Donor"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, donor_path(conn, :create), donor: @invalid_attrs
      assert html_response(conn, 200) =~ "New Donor"
    end
  end

  describe "edit donor" do
    setup [:create_donor]

    test "renders form for editing chosen donor", %{conn: conn, donor: donor} do
      conn = get conn, donor_path(conn, :edit, donor)
      assert html_response(conn, 200) =~ "Edit Donor"
    end
  end

  describe "update donor" do
    setup [:create_donor]

    test "redirects when data is valid", %{conn: conn, donor: donor} do
      conn = put conn, donor_path(conn, :update, donor), donor: @update_attrs
      assert redirected_to(conn) == donor_path(conn, :show, donor)

      conn = get conn, donor_path(conn, :show, donor)
      assert html_response(conn, 200) =~ "some updated address_1"
    end

    test "renders errors when data is invalid", %{conn: conn, donor: donor} do
      conn = put conn, donor_path(conn, :update, donor), donor: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Donor"
    end
  end

  describe "delete donor" do
    setup [:create_donor]

    test "deletes chosen donor", %{conn: conn, donor: donor} do
      conn = delete conn, donor_path(conn, :delete, donor)
      assert redirected_to(conn) == donor_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, donor_path(conn, :show, donor)
      end
    end
  end

  defp create_donor(_) do
    donor = fixture(:donor)
    {:ok, donor: donor}
  end
end
