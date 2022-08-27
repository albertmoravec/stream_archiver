defmodule TwitchApi.EventSub do
  alias TwitchApi.Client

  def subscriptions(params) do
    Client.get("/eventsub/subscriptions", [], params: params)
  end

  def subscribe(body) do
    Client.post("/eventsub/subscriptions", body)
  end
end
