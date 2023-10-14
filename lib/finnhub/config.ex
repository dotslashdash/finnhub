defmodule Finnhub.Config do
  @moduledoc """
  Reads configuration on application start, parses all environment variables (if any)
  and caches the final config in memory to avoid parsing on each read afterwards.
  """

  defstruct api_key: nil,
            http_options: nil,
            api_url: nil

  use GenServer

  @finnhub_url "https://finnhub.io/api"

  @config_keys [
    :api_key,
    :http_options
  ]

  def start_link(opts), do: GenServer.start_link(__MODULE__, opts, name: __MODULE__)

  @impl true
  def init(_opts) do
    config =
      @config_keys
      |> Enum.map(fn key -> {key, get_config_value(key)} end)
      |> Map.new()

      {:ok, config}
  end

  # API Key
  def api_key, do: get_config_value(:api_key)

  # API Url
  def api_url, do: get_config_value(:api_url, @finnhub_url)

  # HTTP Options
  def http_options, do: get_config_value(:http_options, [])

  defp get_config_value(key, default \\ nil) do
    value =
      :finnhub
      |> Application.get_env(key)
      |> parse_config_value()

    if is_nil(value), do: default, else: value
  end

  defp parse_config_value({:system, env_name}), do: System.fetch_env!(env_name)

  defp parse_config_value({:system, :integer, env_name}) do
    env_name
    |> System.fetch_env!()
    |> String.to_integer()
  end

  defp parse_config_value(value), do: value

  def get(key), do: GenServer.call(__MODULE__, {:get, key})

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  @impl true
  def handle_call({:put, key, value}, _from, state) do
    {:reply, value, Map.put(state, key, value)}
  end
end
