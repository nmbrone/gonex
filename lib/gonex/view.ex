defmodule Gonex.View do
  @moduledoc """
  This module contains functions for rendering gon script.
  """

  import Gonex.Controller, only: [get_gon: 1]
  import Phoenix.HTML
  import Phoenix.HTML.Tag

  @doc ~S"""
  Renders gon script.

  Optionally `namespace` can be specified. Default is `"gon"`.

  For converting Elixir map into JavaScript object under the hood it uses
  `Jason.encode!/2` with option `:escape` set to `:html_safe` to prevent XSS.

  ## Examples

      iex>put_gon(conn, greeting: "Hello, World!")

      iex>safe_to_string render_gon(conn)
      "<script type=\"text/javascript\">window.gon={\"greeting\":\"Hello, World!\"}</script>"

      iex>safe_to_string render_gon(conn, "myAppGon")
      "<script type=\"text/javascript\">window.myAppGon={\"greeting\":\"Hello, World!\"}</script>"

  """
  @spec render_gon(Plug.Conn.t()) :: String.t()
  def render_gon(%Plug.Conn{} = conn, namespace \\ "gon") do
    content = conn |> get_gon() |> Jason.encode!(escape: :html_safe)

    content_tag :script, type: "text/javascript" do
      raw("window.#{namespace} = #{content};")
    end
  end
end
