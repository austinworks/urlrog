defmodule Urlrog.Lookup do
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
end
