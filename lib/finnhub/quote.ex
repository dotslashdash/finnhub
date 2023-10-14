defmodule Finnhub.Quote do
  alias Finnhub.Client
  alias Finnhub.Config

  @base_url "/v1/quote"

  def url(), do: @base_url

  def fetch(params, config \\ %Config{}) do
    url()
    |> Client.api_get(config, params)
  end
end
