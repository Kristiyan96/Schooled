defmodule Messages.Helper do
  @secret Application.get_env(:messages, :token)

  def ensure_hash(hash, text) do
    (:crypto.hmac(:sha256, @secret, text) |> Base.encode64) == String.trim(hash)
  end
end
