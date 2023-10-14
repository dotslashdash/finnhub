defmodule Finnhub.Market.Status do
  alias Finnhub.Client
  alias Finnhub.Config

  @base_market_status_url "/v1/stock/market-status"

  def url(), do: @base_market_status_url

  def fetch(params, config \\ %Config{}) do
    Client.api_get(url(), config, params)
  end
end
