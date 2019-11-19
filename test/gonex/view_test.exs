defmodule Gonex.ViewTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Gonex.Controller
  import Gonex.View
  import Phoenix.HTML

  setup do
    gon = %{foo: "bar", xss: "</script><script>alert('XSS attack!')</script>"}
    [conn: conn(:get, "/") |> put_gon(gon)]
  end

  describe "render_gon/2" do
    test "renders the gon script with default namespace", %{conn: conn} do
      expected =
        Enum.join([
          ~s[<script type="text/javascript">],
          ~s[window.gon = {"foo":"bar","xss":"<\\/script><script>alert('XSS attack!')<\\/script>"};],
          ~s[</script>]
        ])

      assert render_gon(conn) |> safe_to_string() == expected
    end

    test "renders the gon script with given namespace", %{conn: conn} do
      assert render_gon(conn, "myAwesomeGon") |> safe_to_string() =~ "window.myAwesomeGon"
    end
  end
end
