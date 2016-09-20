defmodule WikiSearch.CLI do
  @default_language "en"

  def main(args) do
    parse_args(args)
    |> process
    |> extract_from_body
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
  end

  def decode_response({:ok, body}), do: IO.puts is_list(body)
  def decode_response({:error, error}) do
    IO.puts "Error fetching search term"
  end

  def extract_from_body(map) do
    case map do
      {_, map_body} ->
      IO.inspect  Map.keys(map_body)
      IO.inspect Map.has_key?(map_body, "query")
      IO.inspect Map.get(map_body, "query")
    end
  end


  def hale_json({:ok, %{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

end
