defmodule Api.Forum.Forums do
  use Api.Schema
  import Ecto.Changeset
  alias Api.Forum.Categories
  alias Api.Forum.Forums.TitleSlug
  alias Api.Forum.Topics

  schema "bbs_forums" do
    field :description, :string
    field :order, :integer
    field :status, :integer
    field :title, :string

    belongs_to :categories, Categories
    has_many :topics, Topics

    field :slug, TitleSlug.Type

    timestamps()
  end

  @doc false
  def changeset(forums, attrs) do
    forums
    |> cast(attrs, [:id, :title, :description, :status, :order])
    |> cast_assoc(:topics, required: false, with: &Topics.changeset/2)
    |> put_assoc(:categories, :category)
    |> unique_constraint(:title)
    |> validate_required([:title, :description])
  end
end

