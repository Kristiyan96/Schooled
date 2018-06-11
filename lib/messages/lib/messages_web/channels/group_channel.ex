defmodule MessagesWeb.GroupChannel do
  use Phoenix.Channel
  alias MessagesWeb.Presence

  def join("chat:" <> users, _info, socket) do
    Process.flag(:trap_exit, true)

    if users |> String.split(":") |> Enum.member?(socket.assigns.user_id) do
      send(self(), :after_join)
      {:ok, %{}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    users = get_users(socket.topic)

    messages = Messages.between(users)
    push socket, "init:msg", %{messages: messages}

    Presence.track(socket, socket.assigns.user_id, %{})

    {:noreply, socket}
  end

  def handle_in("new:msg", msg, socket) do
    recepient = other_guy(socket.topic, socket.assigns.user_id)

    case Messages.create(socket.assigns.user_id, recepient, msg) do
      {:ok, message} ->
        broadcast! socket, "new:msg", message
        if Enum.count(Presence.list(socket)) == 1 do
          MessagesWeb.Endpoint.broadcast!("user:#{recepient}", "new:msg", %{user_id: socket.assigns.user_id})
        end
      {:error, _changeset} -> nil
    end
    {:reply, :ok, socket}
  end

  def handle_in("read:msg", msg_id, socket) do
    from = other_guy(socket.topic, socket.assigns.user_id)
    Messages.read(msg_id, socket.assigns.user_id, from)
    {:noreply, socket}
  end

  defp get_users(topic) do
    topic
    |> String.replace_prefix("chat:", "")
    |> String.split(":")
  end

  defp other_guy(topic, user_id) do
    [guy] = get_users(topic)
    |> List.delete(user_id)

    guy
  end
end
