defmodule Project1.Server do
    @moduledoc """
    Documentation for Project1.Server module.
    """
    @name :bitcoin_server
    use GenServer
    
    # API

    @doc """
    Code for starting the GenServer that distributes the job of bitcoin mining.
    
    * Starts the GenServer.
    * Registers the server globally.
    * Spawn processes to start worker modules to start the mining process.
    """
    def start_link(state) do

      server_ip = Project1.get_ip(0)
      server = "server@" <> to_string(server_ip)
      Node.start(String.to_atom(server))
      Node.set_cookie(:bitcoin)

      # Registers the GenServer process ID globally.
      {:ok, pid} = GenServer.start_link(__MODULE__, state)
      :global.register_name(@name, pid)

      # Spawns worker processes on the server to start the mining proces.
      no_of_logical_cores = System.schedulers_online()  # Number of logical cores on machine.
      for _ <- 1..no_of_logical_cores do
        ## Generate the random string prefix of length 12.
        string_prefix = :crypto.strong_rand_bytes(12)|> Base.encode16 |> binary_part(0, 12)
        spawn(fn -> Project1.Worker.generate_bitcoins(state, string_prefix) end)
      end
    end
    
    # SERVER

    def init(messages) do
      {:ok, messages}
    end
    
    @doc """
    handle_cast method for GenServer. Prints the bitcoin when notified by a worker.
    """   
    def handle_cast({:bitcoin_found, bitcoin, sha256}, state) do
      IO.puts String.downcase(bitcoin) <> ~s(\t) <> String.downcase(sha256)
      {:noreply, state}
    end
    
    @doc """
    handle_call method for GenServer. Each worker mines bitcoins of length 32.
    When the worker requests the server for work, the server generates a random
    prefix string of length 12. The server then sends this string prefix along with the
    number of leading zeroes to the worker.
    """ 
    def handle_call(:request_work, _from, leading_zero) do
      string_prefix = :crypto.strong_rand_bytes(12)|> Base.encode16 |> binary_part(0, 12)
      {:reply, [leading_zero, string_prefix], leading_zero}
    end
  
    @doc """
    Main module that starts the GenServer to mine bitcoins with the user-specified leading zeroes.
    """
    def main(args) do
      {leading_zero, _} = :string.to_integer(args)
      start_link(leading_zero)
      :timer.sleep(:infinity)
    end
  end 