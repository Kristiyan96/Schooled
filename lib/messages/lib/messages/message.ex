defmodule Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: Timex.Ecto.TimestampWithTimezone,
                    inserted_at: :created_at,
                    autogenerate: {Timex.Ecto.TimestampWithTimezone, :autogenerate, []}]

  schema "messages" do
    field :text, :string
    field :read, :boolean
    field :sender_type, :string
    field :sender_id, :integer
    field :recepient_type, :string
    field :recepient_id, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:text, :sender_type, :sender_id, :recepient_type, :recepient_id])
    |> validate_required([:text, :sender_type, :sender_id, :recepient_type, :recepient_id])
  end
end
