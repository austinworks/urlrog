defmodule Test.ExampleLookup do
	use GenServer

	@impl true
	def init(_) do
		{:ok, %{}}
	end

	def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end

	@impl true
	def handle_cast({:lookup_image, _url}, state) do
		{:noreply, state}
	end

end
