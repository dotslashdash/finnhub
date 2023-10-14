defmodule Finnhub.Client do
  @moduledoc false
  alias Finnhub.{Config}
  use HTTPoison.Base

  def process_url(url), do: Config.api_url() <> url

  def process_response_body(body) do
    try do
      {status, res} = Jason.decode(body)

      case status do
        :ok ->
          {:ok, res}

        :error ->
          body
      end
    rescue
      _ ->
        body
    end
  end

  def handle_response(httpoison_response) do
    case httpoison_response do
      {:ok, %HTTPoison.Response{status_code: 200, body: {:ok, body}}} ->
        res =
          body
          |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
          |> Map.new()

        {:ok, res}

      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{body: {:ok, body}}} ->
        {:error, body}

      {:ok, %HTTPoison.Response{body: {:error, body}}} ->
        {:error, body}

      # html error responses
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, %{status_code: status_code, body: body}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def request_headers(config) do
    api_key = config.api_key || Config.api_key()
    [
      {'X-Finnhub-Token', api_key}
    ]
  end

  #def request_options(config, params \\ []), do: config.http_options || Config.http_options()
  def request_options(config, params) do
    config.http_options || Config.http_options() ++ [params: params]
  end

  def api_get(url, config, params \\ []) do
    url
    |> get(request_headers(config), request_options(config, params))
    |> handle_response()
  end
end
