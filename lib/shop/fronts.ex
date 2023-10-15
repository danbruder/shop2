defmodule Shop.Fronts do
  @moduledoc """
  The Fronts context.
  """

  import Ecto.Query, warn: false
  alias Shop.Repo

  alias Shop.Fronts.Front

  @doc """
  Returns the list of fronts.

  ## Examples

      iex> list_fronts()
      [%Front{}, ...]

  """
  def list_fronts do
    Repo.all(Front)
  end

  @doc """
  Gets a single front.

  Raises `Ecto.NoResultsError` if the Front does not exist.

  ## Examples

      iex> get_front!(123)
      %Front{}

      iex> get_front!(456)
      ** (Ecto.NoResultsError)

  """
  def get_front!(id), do: Repo.get!(Front, id)

  @doc """
  Creates a front.

  ## Examples

      iex> create_front(%{field: value})
      {:ok, %Front{}}

      iex> create_front(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_front(attrs \\ %{}) do
    %Front{}
    |> Front.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a front.

  ## Examples

      iex> update_front(front, %{field: new_value})
      {:ok, %Front{}}

      iex> update_front(front, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_front(%Front{} = front, attrs) do
    front
    |> Front.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a front.

  ## Examples

      iex> delete_front(front)
      {:ok, %Front{}}

      iex> delete_front(front)
      {:error, %Ecto.Changeset{}}

  """
  def delete_front(%Front{} = front) do
    Repo.delete(front)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking front changes.

  ## Examples

      iex> change_front(front)
      %Ecto.Changeset{data: %Front{}}

  """
  def change_front(%Front{} = front, attrs \\ %{}) do
    Front.changeset(front, attrs)
  end
end
