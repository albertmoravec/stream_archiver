defmodule TwitchApi.EventSub do
  alias TwitchApi.Client

  def subscriptions(params) do
    Client.get("/eventsub/subscriptions", [], params: params)
  end

  def subscribe(body) do
    Client.post("/eventsub/subscriptions", body)
  end

  def list(params) do
    Client.get("/eventsub/subscriptions", [], params: params)
  end

  def unsubscribe(params) do
    Client.delete("/eventsub/subscriptions", [], params: params)
  end
end
