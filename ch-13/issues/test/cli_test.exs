defmodule CliTest do
  use ExUnit.Case

  # import Issues.Cli


  test "--help" do
    assert Issues.Cli.parse_opts(["--help", "anything"]) == :help
  end

  test "-h" do
    assert Issues.Cli.parse_opts(["-h", false]) == :help
  end

  test "user project count" do
    assert Issues.Cli.parse_opts(["user", "p1", "9"]) == {"user", "p1", 9}
  end

  test "user project" do
    assert Issues.Cli.parse_opts(["user", "p1"]) == {"user", "p1", 4}
  end

end
