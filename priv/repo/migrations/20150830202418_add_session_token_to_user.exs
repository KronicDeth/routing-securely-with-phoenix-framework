defmodule RoutingSecurelyWithPhoenixFramework.Repo.Migrations.AddSessionTokenToUser do
  use Ecto.Migration

  def down do
    alter table(:users) do
      remove :session_token
    end
  end

  def up do
    alter table(:users) do
      # add session_token as null because it needs to be populated first
      add :session_token, :string, null: true
    end

    # populate with secure random value using same algorithm as `mix phoenix.gen.secret`
    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto"
    execute "UPDATE users SET session_token = encode(gen_random_bytes(64), 'base64') WHERE session_token IS NULL"

    alter table(:users) do
      modify :session_token, :string, null: false
    end
  end 
end
