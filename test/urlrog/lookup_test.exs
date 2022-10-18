defmodule Urlrog.LookupTest do
	use Test.SimpleCase
	alias Urlrog.Lookup

	test "og image finder" do
		assert Lookup.og_image("https://elixirforum.com/t/anonymous-functions-with-multiple-body/3721") == "https://elixirforum.com/uploads/default/original/2X/3/301658d2571b34804e642eb7a28976609422ac3b.png"
	end

end
