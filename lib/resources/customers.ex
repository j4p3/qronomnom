defmodule Qronomnom.Customers do
  @moduledoc """
  Functions for interacting with Customers resource.
  """

  import Response

  @customers_uri "customers/"

  @type customer_type :: %{
          required(:account) => String.t(),
          required(:email) => String.t(),
          optional(:full_name) => String.t(),
          optional(:nickname) => String.t(),
          optional(:phone) => String.t(),
          optional(:metadata) => %{atom: String.t()}
        }

  @doc """
  Lists customers.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Customers.index()
    {:ok, [%{customer_id: "cus_EvLnqYo"}, %{customer_id: "cus_SFOo"}]}
  """
  @spec index(Tesla.Client.t()) :: {:error, any} | {:ok, customer_type()}
  def index(client) do
    Tesla.get(client, @customers_uri)
    |> handle_response()
  end

  @doc """
  Shows a single customer.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Customers.show("cus_EvLnqYo")
    {:ok, %{customer_id: "cus_EvLnqYo"}}
  """
  @spec show(Tesla.Client.t(), String.t()) :: {:error, any} | {:ok, customer_type()}
  def show(client, customer_id) do
    Tesla.get(client, @customers_uri <> "#{customer_id}/")
    |> handle_response()
  end

  @doc """
  Creates a customer.

  Note that `account` must be a valid account ID hash.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Customers.create(%{
          account: "asklf",
          email: "string",
          full_name: "string",
          nickname: "string",
          phone: "string",
          metadata: %{
            additionalProp: "foo"
          }
    })
    {:ok, %{customer_id: "cus_EvLnqYo", ...}}
  """
  @spec create(Tesla.Client.t(), customer_type) :: {:error, any} | {:ok, customer_type()}
  def create(client, customer_data) do
    Tesla.post(client, @customers_uri, customer_data)
    |> handle_response()
  end

  @doc """
  Updates a customer.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Customers.update("cus_EvLnqYo", %{
          email: "string",
          full_name: "string",
          nickname: "string",
          phone: "string",
          metadata: %{
            additionalProp: "foo"
          }
    })
    {:ok, %{customer_id: "cus_EvLnqYo", ...}}
  """
  @spec update(Tesla.Client.t(), String.t(), customer_type) ::
          {:error, any} | {:ok, customer_type()}
  def update(client, customer_id, customer_data) do
    Tesla.patch(client, @customers_uri <> "#{customer_id}/", customer_data)
    |> handle_response()
  end
end
