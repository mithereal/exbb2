defmodule Api.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field(:hash, :string)
    field(:email, :string)
    field(:github_uid, :string)

    has_one(:admin_user, Api.Accounts.User)
    has_many(:users, Api.Accounts.User)

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    hash = hash_id()

    account
    |> cast(attrs, [:hash, :email, :github_uid])
    |> put_change(:hash, hash)
    |> validate_required([:hash, :email])
  end

  defp hash_id(number \\ 20) do
    Base.encode64(:crypto.strong_rand_bytes(number))
  end
end