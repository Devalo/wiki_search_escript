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
    WikiSearch.Search.fetch(search_term)
    |> WikiSearch.MapExtract.extract_from_body
    |> string_format
  end

  def string_format(string) do
    String.replace(string, ". ", ". \n")
    |> IO.puts

  end



end
