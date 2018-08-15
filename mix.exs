defmodule Starter.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: [ignore_warnings: "dialyzer.ignore-warnings"]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:credo, "~> 0.8.8", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false},
      {:inch_ex, "~> 0.5", only: [:dev], runtime: false}
    ]
  end
end
