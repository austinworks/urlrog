defmodule UrlrogWeb.SourceUrlLiveTest do
  use UrlrogWeb.ConnCase

  import Phoenix.LiveViewTest

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  @endpoint UrlrogWeb.Endpoint

  test "basic render", %{conn: conn} do
    conn = get(conn, "/source_urls")
    assert html_response(conn, 200) =~ "<h1>OG Image Lookup Service</h1>"

  end

  test "set query url", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/source_urls")

    view |> form("#query_form") |> render_submit(%{data: %{query_url: "foo"}})

    assert render(view |> element("#image_display")) =~ UrlrogWeb.SourceUrlLive.default_url()
  end

end
