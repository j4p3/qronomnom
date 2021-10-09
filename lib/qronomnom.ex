defmodule Qronomnom do
  @moduledoc """
  Documentation for `Qronomnom`.
  """


  @root_url "https://qrono.dev/"
  @api_uri "api/"
  @bookings_uri "bookings/"

  @require Logger

  @doc """
  Hello world.

  ## Examples

      iex> Qronomnom.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  ## Examples

    iex> Qronomnom.client(%{api_key: "MY_KEY"})
    %Tesla.client{}
  """
  @type client_opts :: %{
    optional(:api_key) => String.t()
  }
  @spec client(client_opts) :: Tesla.Client.t()
  def client(opts \\ %{}) do
    IO.inspect(opts)
    Tesla.client([
      {Tesla.Middleware.BaseUrl, @root_url <> @api_uri},
      {Tesla.Middleware.Headers,
       [
         {"X-API-KEY", Map.get(opts, :api_key, System.get_env("QRONO_API_KEY"))},
         {"Accept", "application/json"}
       ]},
       Tesla.Middleware.JSON
    ])
  end

  @doc """

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.bookings_index()
    {:ok, %Tesla.env}
  """
  @spec bookings_index(binary | Tesla.Client.t()) :: {:error, any} | {:ok, Tesla.Env.t()}
  def bookings_index(client) do
    case Tesla.get(client, @bookings_uri) do
      {:ok, response} ->
        {:ok, Map.get(response, :body)}
      {:error, error} ->
        {:error, error}
    end
  end
end
