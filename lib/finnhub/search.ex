defmodule Finnhub.Search do
  alias Finnhub.Client
  alias Finnhub.Config

  @base_search_url "/v1/search"

  def url(), do: @base_search_url

  def fetch(params, config \\ %Config{}) do
    url()
    |> Client.api_get(config, params)
  end
end
