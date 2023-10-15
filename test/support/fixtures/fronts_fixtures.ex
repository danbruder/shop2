defmodule Shop.FrontsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shop.Fronts` context.
  """

  @doc """
  Generate a front.
  """
  def front_fixture(attrs \\ %{}) do
    {:ok, front} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Shop.Fronts.create_front()

    front
  end
end
