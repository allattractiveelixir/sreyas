defmodule Sreyas.DonationsTest do
  use Sreyas.DataCase

  alias Sreyas.Donations

  describe "donations" do
    alias Sreyas.Donations.Donation

    @valid_attrs %{amount: 120.5, donation_notes: "some donation_notes", donation_program_id: 42, donor_id: 42, payment_method: "some payment_method", username: "some username"}
    @update_attrs %{amount: 456.7, donation_notes: "some updated donation_notes", donation_program_id: 43, donor_id: 43, payment_method: "some updated payment_method", username: "some updated username"}
    @invalid_attrs %{amount: nil, donation_notes: nil, donation_program_id: nil, donor_id: nil, payment_method: nil, username: nil}

    def donation_fixture(attrs \\ %{}) do
      {:ok, donation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Donations.create_donation()

      donation
    end

    test "list_donations/0 returns all donations" do
      donation = donation_fixture()
      assert Donations.list_donations() == [donation]
    end

    test "get_donation!/1 returns the donation with given id" do
      donation = donation_fixture()
      assert Donations.get_donation!(donation.id) == donation
    end

    test "create_donation/1 with valid data creates a donation" do
      assert {:ok, %Donation{} = donation} = Donations.create_donation(@valid_attrs)
      assert donation.amount == 120.5
      assert donation.donation_notes == "some donation_notes"
      assert donation.donation_program_id == 42
      assert donation.donor_id == 42
      assert donation.payment_method == "some payment_method"
      assert donation.username == "some username"
    end

    test "create_donation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Donations.create_donation(@invalid_attrs)
    end

    test "update_donation/2 with valid data updates the donation" do
      donation = donation_fixture()
      assert {:ok, donation} = Donations.update_donation(donation, @update_attrs)
      assert %Donation{} = donation
      assert donation.amount == 456.7
      assert donation.donation_notes == "some updated donation_notes"
      assert donation.donation_program_id == 43
      assert donation.donor_id == 43
      assert donation.payment_method == "some updated payment_method"
      assert donation.username == "some updated username"
    end

    test "update_donation/2 with invalid data returns error changeset" do
      donation = donation_fixture()
      assert {:error, %Ecto.Changeset{}} = Donations.update_donation(donation, @invalid_attrs)
      assert donation == Donations.get_donation!(donation.id)
    end

    test "delete_donation/1 deletes the donation" do
      donation = donation_fixture()
      assert {:ok, %Donation{}} = Donations.delete_donation(donation)
      assert_raise Ecto.NoResultsError, fn -> Donations.get_donation!(donation.id) end
    end

    test "change_donation/1 returns a donation changeset" do
      donation = donation_fixture()
      assert %Ecto.Changeset{} = Donations.change_donation(donation)
    end
  end
end
