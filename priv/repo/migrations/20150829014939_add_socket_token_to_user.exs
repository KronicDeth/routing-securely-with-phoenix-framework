defmodule RoutingSecurelyWithPhoenixFramework.Repo.Migrations.AddChannelTokenToUser do
  use Ecto.Migration

  def down do
    alter table(:users) do
      remove :socket_token
    end
  end

  def up do
    alter table(:users) do
      # add socket_token as null because it needs to be populated first
      add :socket_token, :string, null: true
    end

    # populate with secure random value using same algorithm as `mix phoenix.gen.secret`
    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto"
    execute "UPDATE users SET socket_token = encode(gen_random_bytes(64), 'base64') WHERE socket_token IS NULL"

    alter table(:users) do
      modify :socket_token, :string, null: false
    end
  end
end
