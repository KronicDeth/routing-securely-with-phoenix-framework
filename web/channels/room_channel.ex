defmodule RoutingSecurelyWithPhoenixFramework.RoomChannel do
  use RoutingSecurelyWithPhoenixFramework.Web, :channel

  def join("rooms:lobby", _payload, socket), do: {:ok, socket}

  @doc """
  Get user from `socket` before handling event.
  """
  def handle_in(event, params, socket) do
    user = Repo.get! User, socket.assigns.user_id
    handle_in(event, params, user, socket)
  end

  @doc """
  Broadcast a message from one user to all users (including the originating user)
  """
  def handle_in("new_message", %{"body" => body}, user, socket) do
    broadcast! socket,
               "new_message",
               %{
                  body: body,
                  user: %{
                    name: user.name
                  }
               }
    {:noreply, socket}
  end
end
