defmodule Qronomnom.Bookings do
  @moduledoc """
  Functions for interacting with Bookings resource.
  """

  import Response

  @bookings_uri "bookings/"

  @type customer_type :: %{
          optional(:email) => String.t(),
          optional(:full_name) => String.t(),
          optional(:nickname) => String.t(),
          optional(:phone) => String.t(),
          optional(:metadata) => %{atom: String.t()}
        }
  @type booking_type :: %{
          optional(:description) => String.t(),
          required(:start) => DateTime.t(),
          required(:end) => DateTime.t(),
          required(:item_id) => String.t(),
          optional(:customer) => customer_type,
          optional(:metadata) => %{atom: String.t()},
          optional(:deleted) => boolean()
        }

  @doc """
  Lists bookings.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Bookings.index()
    {:ok, [%{booking_id: "DFfDs.."}, %{booking_id: "SDFdfa..."}]}
  """
  @spec index(Tesla.Client.t()) :: {:error, any} | {:ok, booking_type()}
  def index(client) do
    Tesla.get(client, @bookings_uri)
    |> handle_response()
  end

  @doc """
  Shows a single booking.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Bookings.show("DFfDs")
    {:ok, %{booking_id: "DFfDs.."}}
  """
  @spec show(Tesla.Client.t(), String.t()) :: {:error, any} | {:ok, booking_type()}
  def show(client, booking_id) do
    Tesla.get(client, @bookings_uri <> "#{booking_id}/")
    |> handle_response()
  end

  @doc """
  Creates a booking.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Bookings.create(%{
          description: "string",
          start: "~U[2021-10-11 19:17:02.566057Z]",
          end: "~U[2021-10-11 20:17:02.566057Z]",
          item_id: "itm_EwYbBY2",
          customer: {
            "id": "DFfDs"
          },
          metadata: %{
            additionalProp: "foo"
          },
          deleted: false
    })
    {:ok, %{booking_id: "DFfDs..."}}
  """
  @spec create(Tesla.Client.t(), booking_type) :: {:error, any} | {:ok, booking_type()}
  def create(client, booking_data) do
    Tesla.post(client, @bookings_uri, booking_data)
    |> handle_response()
  end

  @doc """
  Updates a booking.

  ## Examples
    iex> Qronomnom.client(%{api_key: "MY_KEY"}) |> Qronomnom.Bookings.update("DFfDs...", %{
          description: "string",
          start: "~U[2021-10-11 19:17:02.566057Z]",
          end: "~U[2021-10-11 20:17:02.566057Z]",
          item_id: "itm_EwYbBY2",
          customer: {
            "id": "DFfDs"
          },
          metadata: %{
            additionalProp: "foo"
          },
          deleted: false
    })
    {:ok, %{booking_id: "DFfDs..."}}
  """
  @spec update(Tesla.Client.t(), String.t(), booking_type) ::
          {:error, any} | {:ok, booking_type()}
  def update(client, booking_id, booking_data) do
    Tesla.patch(client, @bookings_uri <> "#{booking_id}/", booking_data)
    |> handle_response()
  end
end
