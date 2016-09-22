defmodule WikiSearch.Mixfile do
  use Mix.Project

  def project do
    [app: :wiki_search,
     version: "0.1.0",
     elixir: "~> 1.3",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: WikiSearch.CLI],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end



  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpoison, "~> 0.9.0"},
     {:poison, "~> 2.0"},
     {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp description do
    """
    Retrives Wikipedia articles as a string
    """
  end

  defp package do
    [name: :wiki_search,
     maintainers: ["Stephan Bakkelund Valois"],
     licenses: ["None"],
     links: %{"Github" => "https://github.com/Devalo/wiki_search_escript"}]

  end
end
