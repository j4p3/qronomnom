defmodule Qronomnom.Items do
  @moduledoc """
  Functions for interacting with Items resource.
  """

  import Response

  @items_uri "items/"

  @type booking_interval_type :: :daily | :hourly
  @type item_type :: %{
          optional(:id) =>  String.t(),
          required(:name) => String.t(),
          optional(:default_image) => String.t(),
          required(:handle) => String.t(),
          optional(:description) => String.t(),
          required(:account) => String.t(),
          optional(:booking_interval) => booking_interval_type(),
          optional(:default_available) => boolean(),
          optional(:metadata) => %{atom: String.t()}
        }

  @doc """
  Lists items.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Items.index()
    {:ok, [%{item_id: 1}, %{item_id: 2}]}
  """
  @spec index(Tesla.Client.t()) :: {:error, any} | {:ok, item_type()}
  def index(client) do
    Tesla.get(client, @items_uri)
    |> handle_response()
  end

  @doc """
  Shows a single item.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Items.index()
    {:ok, [%{item_id: "itm_EwYbBY2"}, %{item_id: "itm_LKH5L"}]}
  """
  @spec show(Tesla.Client.t(), String.t()) :: {:error, any} | {:ok, item_type()}
  def show(client, item_id) do
    Tesla.get(client, @items_uri <> "#{item_id}/")
    |> handle_response()
  end

  @doc """
  Creates an item.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Items.create(%{
          name: "string",
          default_image: "string",
          handle: "string",
          description: "string",
          metadata: %{
            additionalProp: "foo"
          },
          booking_interval: :daily,
          default_available: true
    })
    {:ok, %{item_id: "itm_EwYbBY2"}}
  """
  @spec create(Tesla.Client.t(), item_type) :: {:error, any} | {:ok, item_type()}
  def create(client, item_data) do
    Tesla.post(client, @items_uri, item_data)
    |> handle_response()
  end

  @doc """
  Updates an item.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Items.update("itm_EwYbBY2", %{
          name: "string",
          default_image: "string",
          handle: "string",
          description: "string",
          metadata: %{
            additionalProp: "foo"
          },
          booking_interval: :daily,
          default_available: true
    })
    {:ok, %{item_id: "itm_EwYbBY2"}}
  """
  @spec update(Tesla.Client.t(), String.t(), item_type) ::
          {:error, any} | {:ok, item_type()}
  def update(client, item_id, item_data) do
    Tesla.patch(client, @items_uri <> "#{item_id}/", item_data)
    |> handle_response()
  end

  @doc """
  Shows an item's calendar.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Items.calendar()
    {:ok, [%{}, %{}]}
  """
  @spec calendar(Tesla.Client.t(), String.t(), any, any) :: {:error, map} | {:ok, map}
  def calendar(client, item_id, start_datetime, end_datetime) do
    Tesla.get(client, @items_uri <> "#{item_id}/calendar/", query: [start: start_datetime, end: end_datetime])
    |> handle_response()
  end

  @doc """
  Shows an item's timeblocks.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Items.timeblocks()
    {:ok, [%{}, %{}]}
  """
  @spec timeblocks(Tesla.Client.t(), String.t(), any, any) :: {:error, map} | {:ok, map}
  def timeblocks(client, item_id, start_datetime, end_datetime) do
    Tesla.get(client, @items_uri <> "#{item_id}/timeblocks/", query: [start: start_datetime, end: end_datetime])
    |> handle_response()
  end
end
