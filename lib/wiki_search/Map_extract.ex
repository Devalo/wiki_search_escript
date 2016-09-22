defmodule WikiSearch.MapExtract do
  def extract_from_body(map) do
    {_, map_body} = map

    map_query = get_in(map_body, ["query"])
    pages_query = get_in(map_query, ["pages"])
    pages_number = Enum.find(pages_query, fn {k, _v} ->
                    case Integer.parse(k) do
                      :error -> false
                      _ -> k
                      end
                    end)

    {_, extract_search_term_content = pages_number
    Map.fetch!(extract_search_term_content, "extract")
  end
end
