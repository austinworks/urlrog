defmodule Urlrog.Lookup do
	use GenServer

	@impl true
	def init(_) do
		{:ok, %{}}
	end

	def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

	def og_image(url) do
		raw_html = HTTPoison.get!(url).body
		{:ok, html} = Floki.parse_document(raw_html)

		with [{"meta", properties, _}]<- Floki.find(html, "meta[property='og:image']") do
			properties |> Enum.find_value(fn
				{"content", content} -> content
				_ -> nil
			end)
		else
			_ -> nil
		end
	end

	@impl true
	def handle_cast({:lookup_image, page_url}, state ) do
		lookup_url = Map.get(state, page_url, og_image(page_url))
		Phoenix.PubSub.broadcast(Urlrog.PubSub, "new_images", {:update_image, lookup_url, page_url})
		state = Map.put(state, page_url, lookup_url)
		{:noreply, state}
	end
end
