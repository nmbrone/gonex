defmodule Gonex.Controller do
  @moduledoc """
  This module contains functions for working with gon storage.
  """

  @doc """
  Puts given value into gon storage.
  """
  @spec put_gon(Plug.Conn.t(), Map.t()) :: Plug.Conn.t()
  def put_gon(%Plug.Conn{} = conn, map) when is_map(map) do
    Plug.Conn.put_private(conn, :gonex_storage, conn |> get_gon() |> Map.merge(map))
  end

  @spec put_gon(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def put_gon(conn, kwrd) when is_list(kwrd), do: put_gon(conn, Enum.into(kwrd, %{}))

  @spec put_gon(Plug.Conn.t(), atom(), any()) :: Plug.Conn.t()
  def put_gon(conn, key, val) when is_atom(key), do: put_gon(conn, %{key => val})

  @doc """
  Gets the value from gon storage.
  """
  @spec get_gon(Plug.Conn.t()) :: Map.t()
  def get_gon(%Plug.Conn{private: private}), do: Map.get(private, :gonex_storage, %{})

  @spec get_gon(Plug.Conn.t(), atom(), any()) :: any()
  def get_gon(conn, key, default \\ nil), do: conn |> get_gon() |> Map.get(key, default)
end
