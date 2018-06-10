defmodule MessagesWeb.ChatChannel do
  use Phoenix.Channel
  @message [:message, :sender_id, :sender_type, :receiver_id, :receiver_type]
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
    users = socket.topic
            |> String.replace("chat:", "")
            |> String.split(":")

    messages = Messages.between(users)
               |> Enum.map(&(Map.take(&1, @message)))
    push socket, "init:msg", %{messages: messages}

    {:noreply, socket}
  end

  def handle_in("new:msg", msg, socket) do
    [receiver_id] = socket.topic
      |> String.replace_prefix("chat:", "")
      |> String.split(":")
      |> List.delete(socket.assigns.user_id)

    case Messages.create(socket.assigns.user_id, receiver_id, msg) do
      {:ok, message} ->
        broadcast! socket, "new:msg", Map.take(message, @message)
      {:error, _changeset} -> nil
    end
    {:reply, :ok, socket}
  end
end
