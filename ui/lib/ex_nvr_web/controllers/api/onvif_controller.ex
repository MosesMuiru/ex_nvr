defmodule ExNVRWeb.API.OnvifController do
  @moduledoc false

  use ExNVRWeb, :controller

  import ExNVR.Authorization

  alias Ecto.Changeset
  alias ExNVR.Devices

  action_fallback ExNVRWeb.API.FallbackController

  @default_timeout 2

  def discover(conn, params) do
    with :ok <- authorize(conn.assigns.current_user, :onvif, :discover),
         {:ok, params} <- validate_discover_query_params(params),
         discover_params <- Keyword.new(Map.take(params, [:ip_address, :probe_timeout])),
         devices <- Devices.Onvif.discover(discover_params) do
      result = Enum.map(devices, &init_device(&1, params))
      json(conn, result)
    end
  end

  defp init_device(probe, params) do
    case ExOnvif.Device.init(probe, params[:username], params[:password]) do
      {:ok, device} -> device
      {:error, _error} -> probe
    end
  end

  defp validate_discover_query_params(params) do
    types = %{probe_timeout: :integer, ip_address: :string, username: :string, password: :string}

    {%{probe_timeout: @default_timeout, username: "", password: ""}, types}
    |> Changeset.cast(params, Map.keys(types))
    |> Changeset.validate_number(:probe_timeout, less_than_or_equal_to: 60, greater_than: 0)
    |> Changeset.apply_action(:insert)
    |> case do
      {:ok, params} -> {:ok, Map.update!(params, :probe_timeout, &:timer.seconds/1)}
      error -> error
    end
  end
end
