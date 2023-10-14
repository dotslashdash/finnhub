defmodule Finnhub.Calendar.IPO do
  alias Finnhub.Client
  alias Finnhub.Config

  @base_ipo_url "/v1/calendar/ipo"

  def url(), do: @base_ipo_url

  def fetch(params, config \\ %Config{}) do
    url()
    |> Client.api_get(params, config)
  end
end
