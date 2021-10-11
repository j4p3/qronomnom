defmodule Response do
  @moduledoc """
  Utility functions for response parsing.
  """

  @doc """
  Strip Tesla API client metadata & return relevant body.
  """
  @spec handle_response({atom(), Tesla.Env.t()}) :: {:ok, map()} | {:error, map()}
  def handle_response(tesla_response) do
    case tesla_response do
      {:ok, response} ->
        {:ok, Map.get(response, :body)}

      {:error, error} ->
        {:error, error}
    end
  end
end
