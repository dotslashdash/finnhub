defmodule Finnhub.Symbol do
  alias Finnhub.Client
  alias Finnhub.Config

  @base_symbol_url "/v1/stock/symbol"

  def url(), do: @base_symbol_url

  def fetch(params, config \\ %Config{}) do
    url()
    |> Client.api_get(config, params)
  end
end
