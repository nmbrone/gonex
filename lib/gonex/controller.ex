defmodule Gonex.Controller do
  @moduledoc """
  This module contains functions for working with gon storage.
  """

  @doc """
  Merges given `values` into gon storage.

  ## Examples

      iex> get_gon(conn)
      %{}
      iex> put_gon(conn, %{greeting: "Hello, World!"})
      iex> get_gon(conn)
      %{greeting: "Hello, World!"}
      iex> put_gon(conn, greeting: "Hello!")
      iex> get_gon(conn)
      %{greeting: "Hello!"}

  """
  @spec put_gon(Plug.Conn.t(), Map.t() | Keyword.t()) :: Plug.Conn.t()
  def put_gon(%Plug.Conn{} = conn, values) when is_map(values) do
    Plug.Conn.put_private(conn, :gonex_storage, conn |> get_gon() |> Map.merge(values))
  end

  def put_gon(conn, values) when is_list(values), do: put_gon(conn, Enum.into(values, %{}))

  @doc """
  Puts given `value` into gon storage under specified `key`.

  ## Examples

      iex> get_gon(conn)
      %{}
      iex> put_gon(conn, :greeting, "Hello, World!")
      iex> get_gon(conn)
      %{greeting: "Hello, World!"}

  """
  @spec put_gon(Plug.Conn.t(), atom(), any()) :: Plug.Conn.t()
  def put_gon(conn, key, value) when is_atom(key), do: put_gon(conn, %{key => value})

  @doc """
  Gets gon storage.

  ## Examples

      iex> get_gon(conn)
      %{greeting: "Hello, World!"}

  """
  @spec get_gon(Plug.Conn.t()) :: Map.t()
  def get_gon(%Plug.Conn{private: private}), do: Map.get(private, :gonex_storage, %{})

  @doc """
  Gets the value from gon storage.

  ## Examples

      iex> get_gon(conn, :greeting)
      "Hello, World!"
      iex> get_gon(conn, :name)
      nil
      iex> get_gon(conn, :name, "Alice")
      "Alice"

  """
  @spec get_gon(Plug.Conn.t(), atom(), any()) :: any()
  def get_gon(conn, key, default \\ nil), do: conn |> get_gon() |> Map.get(key, default)
end
