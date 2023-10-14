defmodule Finnhub do
  @moduledoc """
  Provides API wrappers for Finnhub API
  See #FIXME for further info on REST endpoints
  """

  use Application

  alias Finnhub.Config

  def start(_type, _args) do
    children = [Config]
    opts = [strategy: :one_for_one, name: Finnhub.Supervisor]

    Supervisor.start_link(children, opts)
  end

  @doc """
  Hello world.

  ## Examples

      iex> Finnhub.hello()
      :world

  """
  def hello do
    :world
  end
end
