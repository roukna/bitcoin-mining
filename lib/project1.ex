defmodule Project1 do
  @moduledoc """
  Documentation for Project1.
  """

  @doc """
  Main module that starts the GenServer to mine bitcoins with the user-specified leading zeroes.

  ## Examples

      # Starts the server to mine bitcoins for 4 leading zeroes.
      $ ./project1 4

      # Starts a worker to connect to the server to participate in bitcoin mining process.
      $ ./project1 192.168.0.103

  """
  def main(args) do
    [cmd_arg] = args
    if String.contains?(cmd_arg, ".") do  # If IP address
        Project1.Worker.main(cmd_arg)
    else  # If number of leading zeroes
       Project1.Server.main(cmd_arg)
    end
  end

  @doc """
  Code to return the IP address of the machine.
  """
  def get_ip(iter) do
    list = Enum.at(:inet.getif() |> Tuple.to_list, 1)
    if (elem(Enum.at(list, iter), 0) == {127, 0, 0, 1}) do
      get_ip(iter+1)
    else
      elem(Enum.at(list, iter), 0) |> Tuple.to_list |> Enum.join(".")
    end
  end
end