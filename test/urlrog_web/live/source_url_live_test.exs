defmodule UrlrogWeb.SourceUrlLiveTest do
  use Test.ConnCase

  import Phoenix.LiveViewTest

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  @endpoint UrlrogWeb.Endpoint

  setup do
    [default_url: "https://assets.wired.com/photos/w_1164/wp-content/uploads/2021/11/Culture-Howard-the-Duck-168583396.jpg" ]
  end

  test "basic render", %{conn: conn} do
    conn = get(conn, "/source_urls")
    assert html_response(conn, 200) =~ "<h1>OG Image Lookup Service</h1>"

  end

  test "update query url", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/source_urls")

    view |> form("#query_form") |> render_submit(%{data: %{query_url: "foo"}})

    assert render(view |> element("#image_description")) =~ "Processing"
  end

  test "image update", %{conn: conn, default_url: default_url} do
    {:ok, view, _html} = live(conn, "/source_urls")

    view |> form("#query_form") |> render_submit(%{"query_url" => "foo"})
    Phoenix.PubSub.broadcast(Urlrog.PubSub, "new_images", {:update_image, default_url, "foo"})

    assert render(view |> element("#image_display")) =~ default_url
  end

end
