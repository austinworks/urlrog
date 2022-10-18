defmodule UrlrogWeb.SourceUrlLive do
  use UrlrogWeb, :live_view

  def default_url do
    "https://assets.wired.com/photos/w_1164/wp-content/uploads/2021/11/Culture-Howard-the-Duck-168583396.jpg"
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, %{
       source_url: "",
       image_url: ""
     })}
  end

  @impl true
  def handle_event("fetchImage", %{"query_url" => query_url}, socket) do
    {:noreply,
     assign(socket, %{
       source_url: query_url,
       image_url: default_url()
     })}
  end
end
