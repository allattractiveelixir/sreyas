defmodule Sreyas.DonorsTest do
  use Sreyas.DataCase

  alias Sreyas.Donors

  describe "donors" do
    alias Sreyas.Donors.Donor

    @valid_attrs %{address_1: "some address_1", address_2: "some address_2", city: "some city", country: "some country", name: "some name", notes: "some notes", phone: "some phone", spiritual_name: "some spiritual_name", state: "some state", username: "some username", zip: "some zip"}
    @update_attrs %{address_1: "some updated address_1", address_2: "some updated address_2", city: "some updated city", country: "some updated country", name: "some updated name", notes: "some updated notes", phone: "some updated phone", spiritual_name: "some updated spiritual_name", state: "some updated state", username: "some updated username", zip: "some updated zip"}
    @invalid_attrs %{address_1: nil, address_2: nil, city: nil, country: nil, name: nil, notes: nil, phone: nil, spiritual_name: nil, state: nil, username: nil, zip: nil}

    def donor_fixture(attrs \\ %{}) do
      {:ok, donor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Donors.create_donor()

      donor
    end

    test "list_donors/0 returns all donors" do
      donor = donor_fixture()
      assert Donors.list_donors() == [donor]
    end

    test "get_donor!/1 returns the donor with given id" do
      donor = donor_fixture()
      assert Donors.get_donor!(donor.id) == donor
    end

    test "create_donor/1 with valid data creates a donor" do
      assert {:ok, %Donor{} = donor} = Donors.create_donor(@valid_attrs)
      assert donor.address_1 == "some address_1"
      assert donor.address_2 == "some address_2"
      assert donor.city == "some city"
      assert donor.country == "some country"
      assert donor.name == "some name"
      assert donor.notes == "some notes"
      assert donor.phone == "some phone"
      assert donor.spiritual_name == "some spiritual_name"
      assert donor.state == "some state"
      assert donor.username == "some username"
      assert donor.zip == "some zip"
    end

    test "create_donor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Donors.create_donor(@invalid_attrs)
    end

    test "update_donor/2 with valid data updates the donor" do
      donor = donor_fixture()
      assert {:ok, donor} = Donors.update_donor(donor, @update_attrs)
      assert %Donor{} = donor
      assert donor.address_1 == "some updated address_1"
      assert donor.address_2 == "some updated address_2"
      assert donor.city == "some updated city"
      assert donor.country == "some updated country"
      assert donor.name == "some updated name"
      assert donor.notes == "some updated notes"
      assert donor.phone == "some updated phone"
      assert donor.spiritual_name == "some updated spiritual_name"
      assert donor.state == "some updated state"
      assert donor.username == "some updated username"
      assert donor.zip == "some updated zip"
    end

    test "update_donor/2 with invalid data returns error changeset" do
      donor = donor_fixture()
      assert {:error, %Ecto.Changeset{}} = Donors.update_donor(donor, @invalid_attrs)
      assert donor == Donors.get_donor!(donor.id)
    end

    test "delete_donor/1 deletes the donor" do
      donor = donor_fixture()
      assert {:ok, %Donor{}} = Donors.delete_donor(donor)
      assert_raise Ecto.NoResultsError, fn -> Donors.get_donor!(donor.id) end
    end

    test "change_donor/1 returns a donor changeset" do
      donor = donor_fixture()
      assert %Ecto.Changeset{} = Donors.change_donor(donor)
    end
  end
end
