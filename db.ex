defmodule Db do
  @moduledoc """
  Implement a database using a list of {key,value} tuples.
  """

  @type db() :: list()
  @doc "Create a new database."
  @spec new() :: db()
  def new() do
    []
  end

  @doc "Insert a new element in the database."
  @spec write(db(), term, term) :: db()
  def write([], key, element) do
    [{key, element}]
  end

  def write([{key, _} | db], key, element) do
    [{key, element}|db]
  end

  def write([current | db], key, element) do
    [current | write(db, key, element)]
  end

  @doc "Remove an element from the database."
  @spec delete(db(), term) :: db()

  def delete([{key, _element}|db], key) do
    db
  end

  def delete([tuple|db], key) do
    [tuple|delete(db, key)]
  end

  def delete([], _key) do
    []
  end

  @doc "Retrieve the first element in the database with a matching key."
  @spec read(db(), term) :: {:ok, term} | {:error, :instance}
  def read([{key, element}|_db], key) do
    {:ok, element}
  end

  def read([_tuple|db], key) do
    read(db, key)
  end

  def read([], _key) do
    {:error, :instance}
  end
  
  @doc "Return all the keys whose values match the given element."
  @spec match(db(), term) :: [term]
  def match([{key, element}|db], element) do
    [key|match(db, element)]
  end

  def match([_tuple|db], element) do
    match(db, element)
  end

  def match([], _element) do
    []
  end

  @doc "Deletes the database."
  @spec destroy(db()) :: :ok
  def destroy(_db) do
    :ok
  end
end