defmodule Shop.FrontsTest do
  use Shop.DataCase

  alias Shop.Fronts

  describe "fronts" do
    alias Shop.Fronts.Front

    import Shop.FrontsFixtures

    @invalid_attrs %{name: nil}

    test "list_fronts/0 returns all fronts" do
      front = front_fixture()
      assert Fronts.list_fronts() == [front]
    end

    test "get_front!/1 returns the front with given id" do
      front = front_fixture()
      assert Fronts.get_front!(front.id) == front
    end

    test "create_front/1 with valid data creates a front" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Front{} = front} = Fronts.create_front(valid_attrs)
      assert front.name == "some name"
    end

    test "create_front/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Fronts.create_front(@invalid_attrs)
    end

    test "update_front/2 with valid data updates the front" do
      front = front_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Front{} = front} = Fronts.update_front(front, update_attrs)
      assert front.name == "some updated name"
    end

    test "update_front/2 with invalid data returns error changeset" do
      front = front_fixture()
      assert {:error, %Ecto.Changeset{}} = Fronts.update_front(front, @invalid_attrs)
      assert front == Fronts.get_front!(front.id)
    end

    test "delete_front/1 deletes the front" do
      front = front_fixture()
      assert {:ok, %Front{}} = Fronts.delete_front(front)
      assert_raise Ecto.NoResultsError, fn -> Fronts.get_front!(front.id) end
    end

    test "change_front/1 returns a front changeset" do
      front = front_fixture()
      assert %Ecto.Changeset{} = Fronts.change_front(front)
    end
  end
end
