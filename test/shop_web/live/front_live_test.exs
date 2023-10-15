defmodule ShopWeb.FrontLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.FrontsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_front(_) do
    front = front_fixture()
    %{front: front}
  end

  describe "Index" do
    setup [:create_front]

    test "lists all fronts", %{conn: conn, front: front} do
      {:ok, _index_live, html} = live(conn, ~p"/fronts")

      assert html =~ "Listing Fronts"
      assert html =~ front.name
    end

    test "saves new front", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/fronts")

      assert index_live |> element("a", "New Front") |> render_click() =~
               "New Front"

      assert_patch(index_live, ~p"/fronts/new")

      assert index_live
             |> form("#front-form", front: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#front-form", front: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fronts")

      html = render(index_live)
      assert html =~ "Front created successfully"
      assert html =~ "some name"
    end

    test "updates front in listing", %{conn: conn, front: front} do
      {:ok, index_live, _html} = live(conn, ~p"/fronts")

      assert index_live |> element("#fronts-#{front.id} a", "Edit") |> render_click() =~
               "Edit Front"

      assert_patch(index_live, ~p"/fronts/#{front}/edit")

      assert index_live
             |> form("#front-form", front: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#front-form", front: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/fronts")

      html = render(index_live)
      assert html =~ "Front updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes front in listing", %{conn: conn, front: front} do
      {:ok, index_live, _html} = live(conn, ~p"/fronts")

      assert index_live |> element("#fronts-#{front.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#fronts-#{front.id}")
    end
  end

  describe "Show" do
    setup [:create_front]

    test "displays front", %{conn: conn, front: front} do
      {:ok, _show_live, html} = live(conn, ~p"/fronts/#{front}")

      assert html =~ "Show Front"
      assert html =~ front.name
    end

    test "updates front within modal", %{conn: conn, front: front} do
      {:ok, show_live, _html} = live(conn, ~p"/fronts/#{front}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Front"

      assert_patch(show_live, ~p"/fronts/#{front}/show/edit")

      assert show_live
             |> form("#front-form", front: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#front-form", front: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/fronts/#{front}")

      html = render(show_live)
      assert html =~ "Front updated successfully"
      assert html =~ "some updated name"
    end
  end
end
