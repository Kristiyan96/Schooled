defmodule MessagesWeb.GroupChannel do
  use Phoenix.Channel
  alias MessagesWeb.Presence

  # Define student group
  def join("group:" <> group, _info, socket) do
    groups = Messages.groups(socket.assigns.user_id)
    if Enum.member?(group, groups) do
      send(self(), :after_join)
      {:ok, %{}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    group = get_group(socket.topic)

    messages = Messages.for_group(group, socket.assigns.user_id)
    push socket, "init:msg", %{messages: messages}

    Presence.track(socket, socket.assigns.user_id, %{})

    {:noreply, socket}
  end

  def handle_in("new:msg", msg, socket) do
    group = get_group(socket.topic)

    case Messages.create_group(socket.assigns.user_id, group, msg) do
      {:ok, message} ->
        broadcast! socket, "new:msg", message

        if Enum.count(Presence.list(socket)) == 1 do
          offline = Messages.users_in_group(group) -- Presence.list(socket)
          Task.async(fn ->
            offline
            |> Enum.each(fn recipient ->
              MessagesWeb.Endpoint.broadcast!("user:#{recipient}", "new:msg", %{group_id: group})
            end)
          end)
        end
      {:error, _changeset} -> nil
    end
    {:reply, :ok, socket}
  end

  def handle_in("read:msg", msg_id, socket) do
    group = get_group(socket.topic)
    Messages.read(msg_id, socket.assigns.user_id, group, "Group")
    {:noreply, socket}
  end

  defp get_group(topic) do
    String.replace_prefix(topic, "group:", "")
  end
end
