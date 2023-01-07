defmodule Api.ProductsTest do
  use Api.DataCase

  alias Api.Products

  describe "products" do
    alias Api.Products.Product

    @valid_attrs %{
      description: "some description",
      name: "some name",
      price: "120.50",
      type: "test",
      link: "/"
    }
    @update_attrs %{
      description: "some updated description",
      name: "some updated name",
      price: "456.70"
    }
    @invalid_attrs %{description: nil, name: nil, price: nil, slug: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Products.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      [data] = Products.list_products()
      assert product.name == data.name
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      data = Products.get_product!(product.id)
      assert data.name == product.name
    end

    test "get_product_by_slug/1 returns the product with given slug" do
      product = product_fixture()
      data = Products.get_product_by_slug(product.slug)
      assert data.name == product.name
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Products.create_product(@valid_attrs)
      assert product.description == "some description"
      assert product.name == "some name"
      assert product.price == Decimal.new("120.50")
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Products.update_product(product, @update_attrs)
      assert product.description == "some updated description"
      assert product.name == "some updated name"
      assert product.price == Decimal.new("456.70")
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      data = Products.get_product!(product.id)
      assert product.name == data.name
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end