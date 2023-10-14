defmodule Finnhub.Profile do
  alias Finnhub.Client
  alias Finnhub.Config

  @base_profile_url "/v1/stock/profile2"

  def url(), do: @base_profile_url

  def fetch(params, config \\ %Config{}) do
    Client.api_get(url(), config, params)
  end
end
