defmodule Mutex do
	@moduledoc """
	Implements a mutex binary semaphore
	"""

	@doc "Will start the mutex semaphore"
	@spec start() :: true
	def start() do
		Process.register(spawn(Mutex, :init, []), :mutex)
	end

	@doc "Will keep the process busy until the semaphore is available"
	@spec wait() :: :ok
	def wait() do
		send(:mutex, {:wait, self()})
		receive do
			:ok -> :ok
		end
	end

	## @private Initialise the state machine
	@spec init() :: no_return
	def init() do
		free()
	end

	defp free() do
		receive do
			{:wait, pid} -> 
				send(pid, :ok)
				busy(pid)
		end
	end

	def busy(pid) do
		receive do
			{:signal, ^pid} -> free()
		end
	end
end