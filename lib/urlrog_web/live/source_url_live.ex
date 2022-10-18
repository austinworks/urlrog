defmodule UrlrogWeb.SourceUrlLive do
  use UrlrogWeb, :live_view


  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(Urlrog.PubSub, "new_images")
    {:ok,
     assign(socket, %{
       source_url: "",
       image_url: "",
       image_url_description: ""
     })}
  end

  @impl true
  def handle_event("updateQuery", %{"query_url" => query_url}, socket) do
    GenServer.cast(Application.get_env(:urlrog, :image_processor), {:lookup_image, query_url})
    {:noreply,
     assign(socket, %{
       source_url: query_url,
       image_url_description: "Processing...",
       image_url: ""
     })}
  end

  @impl true
  def handle_info({:update_image, image_url, query_url}, socket) do
    if query_url == socket.assigns.source_url do
      {:noreply,
        assign(socket, %{
          image_url: image_url,
          image_url_description: image_url || "Not found"
        })}
    else
      {:noreply, socket}
    end
  end
end
