defmodule Finnhub.Metrics do
  alias Finnhub.Client
  alias Finnhub.Config

  @base_metrics_url "/v1/stock/metric"

  def url(), do: @base_metrics_url

  def fetch(params, config \\ %Config{}) do
    Client.api_get(url(), config, params)
  end
end
