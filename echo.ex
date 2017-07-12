defmodule Echo do
	@moduledoc """
	Implements a server which print messages sent to it
	"""

	@doc "Start the echo server"
	@spec start() :: :ok

	def start() do
		Process.register(spawn(Echo, :listen, []), :echo)
		:ok
	end

	@doc "Print a term passed as an argument"
	@spec print(term) :: :ok

	def print(message) do
		send(:echo, {:print, message})
	end

	@doc "Stop the echo server"
	@spec stop() :: :ok

	def stop() do
		send(:echo, :stop)
		:ok
	end

	@doc "The echo server loop"
	@spec listen() :: true

	def listen() do
		receive do
			{:print, message} ->
				IO.puts(inspect(message))
				listen()
			:stop ->
				:ok
		end
	end
end