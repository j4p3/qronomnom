# Qronomnom

**Elixir functions for interacting with Qrono bookings API**

WIP [Qrono](https://qrono.dev/) wrapper.

## Installation

The package can be installed by adding `qronomnom` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:qronomnom, "~> 0.1.1"}
  ]
end
```

## Usage

Ensure `QRONO_API_KEY` is set in your environment, or passed to `client/1`.

```
iex> Qronomnom.client() |> Qronomnom.Bookings.list()
{:ok, [%{booking_id: "DFfDs...", ...}, %{booking_id: "SDFdfa...", ...}]}

```

## Documentation

[https://hexdocs.pm/qronomnom/](https://hexdocs.pm/qronomnom/)

## Development

* clone this repository
* run `mix deps.get`
* ensure you've created an API key for your account
