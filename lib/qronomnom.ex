defmodule Qronomnom do
  @moduledoc """
  Documentation for `Qronomnom`.
  """

  @root_url "https://qrono.dev/"
  @api_uri "api/"

  @doc """
  Generates a new authenticated client.

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
end
