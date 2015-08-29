defmodule RoutingSecurelyWithPhoenixFramework.UserSocket do
  use Phoenix.Socket

  alias RoutingSecurelyWithPhoenixFramework.Repo
  alias RoutingSecurelyWithPhoenixFramework.User

  ## Channels
  channel "rooms:*", RoutingSecurelyWithPhoenixFramework.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  @seconds_per_minute 60
  @minutes_per_hour 60
  @hours_per_day 24
  @days_per_week 7
  @token_max_age 2 * @days_per_week * @hours_per_day * @minutes_per_hour *
                 @seconds_per_minute

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "user", token, max_age: @token_max_age) do
      {:ok, {id, socket_token}} ->
        connect_user_id_and_socket_token(socket, id, socket_token)
      {:error, reason} ->
        :error
    end
  end

  @doc """
  Group all sockets for a given user together so they can be disconnected.

  # Disconnecting a compromised user

      iex> RoutingSecurelyWithPhoenixFramework.Endpoint.broadcast("user_sockets:" <> user.id, "disconnect")
  """
  def id(socket), do: "user_sockets:#{socket.assigns.user_id}"

  # Private Functions

  defp connect_user(socket, user) do
    socket = assign(socket, :user_id, user.id)
    {:ok, socket}
  end

  defp connect_user_id_and_socket_token(socket, id, socket_token) do
    user = Repo.get_by!(User, id: id, socket_token: socket_token)
    connect_user socket, user
  end
end
