defmodule Finnhub.Calendar.Earnings do
  alias Finnhub.Client
  alias Finnhub.Config

  @base_earnings_url "/v1/calendar/earnings"

  def url(), do: @base_earnings_url

  def fetch(params, config \\ %Config{}) do
    url()
    |> Client.api_get(config, params)
  end
end
