defmodule HelloWeb.RoomChannel do
  use Phoenix.Channel
  alias HelloWeb.Presence
  require Logger

  def join("room:lobby", message, socket) do
    Process.flag(:trap_exit, true)
    :timer.send_interval(5000, :ping)
    send(self, {:after_join, message})

    {:ok, socket}
  end
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info({:after_join, msg}, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
        online_at: inspect(System.system_time(:second))
      })
    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
    # Before Presence addition
    # broadcast! socket, "user:entered", %{user: msg["user"]}
    # push socket, "join", %{status: "connected"}
    # {:noreply, socket}
  end
  def handle_info(:ping, socket) do
    push socket, "new:msg", %{user: "SYSTEM", body: "ping"}
    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end
end