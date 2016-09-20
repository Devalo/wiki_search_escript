defmodule WikiSearch.SearchEngine do
  @wiki_url Application.get_env(:wiki_search, :wiki_url)

  def fetch(search_term) do
    wiki_url(search_term)
    |> HTTPoison.get
    |> handle_json

  end

  def wiki_url(search_term) do
    "#{@wiki_url}#{search_term}"
  end

  def handle_json({:ok, %{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end
  def handle_json({_, %{status_code: _, body: body}}) do
    {:error, Poison.Parser.parse!(body)}
  end
end
