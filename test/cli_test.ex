defmodule CliTest do
  use ExUnit.case
  doctest WikiSearch

  test ":help returned when parsing -h or --help" do
    assert parse_args(["-h"], "anything") == :help
    assert parse_args(["--help"], "anything") == :help
  end

  test "Search term received from parse" do
    assert parse_args(["search_term"]) == {search_term}
  end


end
