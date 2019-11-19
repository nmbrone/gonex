defmodule Gonex.View do
  import Gonex.Controller, only: [get_gon: 1]
  import Phoenix.HTML
  import Phoenix.HTML.Tag

  @doc """
  Renders gon script.
  """
  @spec render_gon(Plug.Conn.t()) :: String.t()
  def render_gon(%Plug.Conn{} = conn, namespace \\ "gon") do
    content = conn |> get_gon() |> Jason.encode!(escape: :html_safe)

    content_tag :script, type: "text/javascript" do
      raw("window.#{namespace} = #{content};")
    end
  end
end
