defmodule Project1.Worker do
    @moduledoc """
    Documentation for Project1.Worker module.
    """
  
    @name :bitcoin_server
    
    @doc """
    Code for connecting the worker to the GenServer.
    """
    def connect_to_genserver(server_ip) do
      
      worker_ip = Project1.get_ip(0)
      server = "server@" <> to_string(server_ip)
      worker_id = Enum.random(1..1000)
      worker = "worker" <> to_string(worker_id) <> "@" <> to_string(worker_ip)
      
      Node.start(String.to_atom(worker))
      Node.set_cookie(:bitcoin)
      # Connects to the server
      Node.connect(String.to_atom(server))
    end
    
    @doc """
    Code for the Worker that requests the GenServer for work.
    """
    def request_work() do
      :global.sync()
      GenServer.call(:global.whereis_name(@name), :request_work)
    end
    
    @doc """
    Code for generating the bitcoins with specified number of leading zeroes. The worker receives
    the string prefix of length 12 from the server and the number of leading zeroes. The worker on each computation
    generates the remaining 20 bits of the 32 bit string and hashes it to check for leading zeroes.
    """
    def generate_bitcoins(leading_zero, string_prefix) do
      
      ## Generate the candidate string.
      ## Randomly generates the string suffix of length 20 
      ## and appends it to the gator id and the string prefix sent by the server.
      random_string = "rsengupta;" <> string_prefix <> (:crypto.strong_rand_bytes(20)|> Base.encode16 |> binary_part(0, 20))
      sha256 = :crypto.hash(:sha256, random_string) |> Base.encode16
      sliced_string = String.slice(sha256, 0, leading_zero)
      string_zero = String.duplicate("0", leading_zero)
  
      if sliced_string == string_zero do
        :global.sync()
        # Notify server with the bitcoin found.
        GenServer.cast(:global.whereis_name(@name), {:bitcoin_found,random_string, sha256})
      end
      generate_bitcoins(leading_zero, string_prefix)
    end
  
    @doc """
    Main module that starts the Worker which connects to the GenServer and requests work.
  
    * Connects to the server.
    * Requests work from the server.
    * Spawns processes to start worker modules to start the mining process.
    """
    def main(args) do
      server_ip = args
      connect_to_genserver(server_ip)
      [leading_zero, string_prefix] = request_work()
      no_of_workers = System.schedulers_online()  # Number of logical cores on machine.
      
      # Spawns worker processes on the server to start the mining proces.
      for _ <- 1..no_of_workers do
        spawn(fn -> generate_bitcoins(leading_zero, string_prefix) end)
      end
      :timer.sleep(:infinity)
    end
  end  