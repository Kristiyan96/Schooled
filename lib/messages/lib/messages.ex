defmodule Messages do
  alias Messages.{Repo, Message}
  import Ecto.Query, only: [from: 2]

  @moduledoc """
  Messages keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def between(users) do
    from(
      m in Message,
      where:
        m.sender_type == "User" and m.recepient_type == "User" and m.sender_id in ^users and
          m.recepient_id in ^users,
      order_by: m.id
    )
    |> select_message
    |> Repo.all()
  end

  def unread(user_id) do
    from(
      m in Message,
      where: m.recepient_id == ^user_id and m.recepient_type == "User" and m.read == false,
      select: [m.sender_id, m.sender_type],
      distinct: true
    )
    |> Repo.all()
    |> Enum.group_by(fn [_id, type] -> type end, fn [id, _type] -> [id] end)
  end

  def read(id, recepient, sender) do
    from(
      m in Message,
      where:
        m.recepient_id == ^recepient and m.sender_id == ^sender and m.sender_type == "User" and
          m.recepient_type == "User" and m.id <= ^id
    )
    |> select_message
    |> Repo.update_all(set: [read: true])
  end

  def create(sender_id, recepient_id, message) do
    changes = %{
      sender_id: sender_id,
      sender_type: "User",
      recepient_id: recepient_id,
      recepient_type: "User",
      text: message
    }

    Message.changeset(%Message{}, changes)
    |> Repo.insert()
  end

  defp select_message(query) do
    from m in query,
      select: [m.text, m.sender_id, m.sender_type, m.recepient_id, m.recepient_type]
  end
end
