defmodule Finnhub.Calendar.Earnings do
  alias Finnhub.Client
  alias Finnhub.Config

  @base_url "/v1/calendar/earnings"

  def url(), do: @base_url

  def fetch(config \\ %Config{}) do
    url()
    |> Client.api_get(config)
  end
end
