defmodule Gonex.MixProject do
  use Mix.Project

  def project do
    [
      app: :gonex,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Gonex",
      description: "Gonex - get your Phoenix variables in your Javascript",
      source_url: "https://github.com/nmbrone/gonex",
      homepage_url: "https://github.com/nmbrone/gonex",
      package: [
        maintainers: ["Sergey Snozyk"],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/nmbrone/gonex"}
      ],
      docs: [
        main: "Gonex",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.1"},
      {:plug, "~> 1.0"},
      {:phoenix_html, "~> 2.7"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end
end
