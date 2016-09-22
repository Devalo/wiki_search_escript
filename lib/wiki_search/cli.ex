defmodule WikiSearch.CLI do
  @default_language "en"

  def main(args) do
    parse_args(args)
    |> process
  end

  def parse_args(args) do
    parse = OptionParser.parse(args, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _}
        -> :help
      {_, [search_term], _}
        -> {search_term}
    end
  end

  def process(:help) do
    IO.puts """
    WikiSearch
    ----------
    usage: wiki_search <search_term>
    example: wiki_search lion
    """
  end

  def process({search_term}) do
    WikiSearch.SearchEngine.fetch(search_term)
    |> extract_from_body
  end

  def decode_response({:ok, body}), do: IO.puts is_list(body)
  def decode_response({:error, _error}) do
    IO.puts "Error fetching search term"
  end

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
    {_, extract_body} = pages_number
    IO.inspect Map.fetch!(extract_body, "extract")
  end


  def hale_json({:ok, %{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

end
