defmodule Qronomnom.Hooks do
  @moduledoc """
  Functions for interacting with Hooks resource.
  """

  import Response

  @hooks_uri "hooks/"

  @type hook_type :: %{
          required(:target_url) => String.t(),
          required(:event) => String.t()
        }

  @doc """
  Lists hooks.

  ## Examples

      iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Hooks.index()
      {:ok, [%{hook_id: 1}, %{hook_id: 2}]}
  """
  @spec index(Tesla.Client.t()) :: {:error, any} | {:ok, hook_type()}
  def index(client) do
    Tesla.get(client, @hooks_uri)
    |> handle_response()
  end

  @doc """
  Shows a single hook.

  ## Examples

      iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Hooks.show(1)
      {:ok, %{hook_id: 1}}
  """
  @spec show(Tesla.Client.t(), integer()) :: {:error, any} | {:ok, hook_type()}
  def show(client, hook_id) do
    Tesla.get(client, @hooks_uri <> "#{hook_id}/")
    |> handle_response()
  end

  @doc """
  Creates a hook. Note that the value of `:event` in the hook map must be one of the strings specified by Qrono: either `"bookings.created"` or `"bookings.updated"`.

  ## Examples

      iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Hooks.create(%{
            target_url: "https://my_project.dev/webhooks_listener",
            event: "bookings.created"
      })
      {:ok, %{hook_id: 1, ...}}
  """
  @spec create(Tesla.Client.t(), hook_type) :: {:error, any} | {:ok, hook_type()}
  def create(client, hook_data) do
    Tesla.post(client, @hooks_uri, hook_data)
    |> handle_response()
  end

  @doc """
  Updates a hook. Note that the value of `:event` in the hook map must be one of the strings specified by Qrono: either `"bookings.created"` or `"bookings.updated"`.

  ## Examples

      iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Hooks.update(1, %{
            target_url: "https://my_project.dev/webhooks_listener_2",
            event: "bookings.created"
      })
      {:ok, %{hook_id: 1, ...}}
  """
  @spec update(Tesla.Client.t(), integer(), hook_type) ::
          {:error, any} | {:ok, hook_type()}
  def update(client, hook_id, hook_data) do
    Tesla.patch(client, @hooks_uri <> "#{hook_id}/", hook_data)
    |> handle_response()
  end

  @doc """
  Destroys a hook.

  ## Examples

      iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Hooks.destroy(1)
      {:ok, %{hook_id: 1, ...}}
  """
  @spec destroy(Tesla.Client.t(), integer()) :: {:error | :ok, %{}}
  def destroy(client, hook_id) do
    Tesla.delete(client, @hooks_uri <> "#{hook_id}/")
    |> handle_response()
  end
end
