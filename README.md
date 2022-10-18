# Urlrog: URL Retrieval for Open Graph

To start the Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Also, try running tests with `mix test`

## What you should know

- I did it in Phoenix.  Live view seemed like a good match for the requirements, so I used a live view.
- No database. Why would this app need one?
- Using GenServer as a background processor. No need for Redis or Sidekiq, start up a GenServer thread to do the webscraping when the application starts
- The GenServer is stateful and caches the scraped value for each of the URLs you look up with it, so future requests should be faster.
- Updates via PubSub. Any listening LiveView that is looking for the thumbnail for the requested URL will receive the update.
- Using Application.get_env for test dependency injection, meaning we don't get slowdowns or errors from attempts to call HTTPoison in test.  This comes with a slight sacrifice to readability and click-through-ability, but is still pretty cool.  Another approach this would be to use (Gestalt)[https://hex.pm/packages/gestalt]
- There are tests, ain't that great?
