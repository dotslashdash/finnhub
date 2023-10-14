defmodule Finnhub.Market.Holiday do
  alias Finnhub.Client
  alias Finnhub.Config

  @base_market_holiday_url "/v1/stock/market-holiday"

  def url(), do: @base_market_holiday_url

  def fetch(params, config \\ %Config{}) do
    Client.api_get(url(), config, params)
  end
end
