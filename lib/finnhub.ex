defmodule Finnhub do
  @moduledoc """
  Provides API wrappers for Finnhub API
  See #FIXME for further info on REST endpoints
  """

  use Application

  alias Finnhub.Config
  alias Finnhub.Filings
  alias Finnhub.Metrics
  alias Finnhub.Profile
  alias Finnhub.Quote
  alias Finnhub.Search
  alias Finnhub.Symbol
  alias Finnhub.Calendar.Earnings
  alias Finnhub.Calendar.IPO
  alias Finnhub.Market.Holiday
  alias Finnhub.Market.Status

  def start(_type, _args) do
    children = [Config]
    opts = [strategy: :one_for_one, name: Finnhub.Supervisor]

    Supervisor.start_link(children, opts)
  end

  @doc """
  It returns a quote for a stock

  ## Examples

      iex> Finnhub.quote([symbol: "AAPL"])
      {:ok,
       %{
         c: 178.85,
         d: -1.86,
         dp: -1.0293,
         h: 181.93,
         l: 178.14,
         o: 181.42,
         pc: 180.71,
         t: 1697227201
       }}

  """
  def quote(params, config \\ %Config{}) do
    Quote.fetch(params, config)
  end

  def earnings_calendar(params \\ [], config \\ %Config{}) do
    Earnings.fetch(params, config)
  end

  def ipo_calendar(params, config \\ %Config{}) do
    IPO.fetch(params, config)
  end

  def market_holiday(params, config \\ %Config{}) do
    Holiday.fetch(params, config)
  end

  def market_status(params, config \\ %Config{}) do
    Status.fetch(params, config)
  end

  def metrics(params, config \\ %Config{}) do
    Metrics.fetch(params, config)
  end

  def profile(params, config \\ %Config{}) do
    Profile.fetch(params, config)
  end

end
