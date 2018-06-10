defmodule Messages do
  alias Messages.{Repo,Message}
  import Ecto.Query, only: [from: 2]

  @moduledoc """
  Messages keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def between(users) do
    Repo.all(
      from m in Message,
      where: m.sender_type == "User" and m.receiver_type == "User" and
        m.sender_id in ^users and m.receiver_id in ^users,
      order_by: m.id
    )
  end

  def create(sender_id, receiver_id, message) do
    changes = %{
      sender_id: sender_id,
      sender_type: "User",
      receiver_id: receiver_id,
      receiver_type: "User",
      text: message,
    }

    Message.changeset(%Message{}, changes)
    |> Repo.insert
  end
end
