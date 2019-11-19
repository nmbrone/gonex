defmodule Gonex.ControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  import Gonex.Controller

  setup do
    [
      conn: conn(:get, "/"),
      conn_gon: conn(:get, "/") |> put_private(:gonex_storage, %{foo: "bar"})
    ]
  end

  describe "put_gon/2" do
    test "puts given map into the storage", ctx do
      map = %{bar: "baz"}
      conn = put_gon(ctx.conn, map)
      assert conn.private.gonex_storage == map
      conn = put_gon(ctx.conn_gon, map)
      assert conn.private.gonex_storage == %{foo: "bar", bar: "baz"}
    end

    test "puts given keyword list into the storage", ctx do
      kwrd = [bar: "baz"]
      conn = put_gon(ctx.conn, kwrd)
      assert conn.private.gonex_storage == %{bar: "baz"}
      conn = put_gon(ctx.conn_gon, kwrd)
      assert conn.private.gonex_storage == %{foo: "bar", bar: "baz"}
    end

    test "puts given value into the storage", ctx do
      conn = put_gon(ctx.conn, :bar, "baz")
      assert conn.private.gonex_storage == %{bar: "baz"}
      conn = put_gon(ctx.conn_gon, :bar, "baz")
      assert conn.private.gonex_storage == %{foo: "bar", bar: "baz"}
    end
  end

  describe "get_gon/1" do
    test "returns default storage", %{conn: conn} do
      assert %{} == get_gon(conn)
    end

    test "returns the storage", %{conn_gon: conn} do
      assert %{foo: "bar"} = get_gon(conn)
    end
  end

  describe "get_gon/3" do
    test "returns the value from the storage", %{conn_gon: conn} do
      assert "bar" == get_gon(conn, :foo)
      assert nil == get_gon(conn, :bar)
    end

    test "returns default value", %{conn_gon: conn} do
      assert "bar" == get_gon(conn, :bar, "bar")
    end
  end
end
