defmodule Seq do
	def rc(0) do [] end
	def rc(n) when n > 0 do
		[n|rc(n-1)]
	end

	def c(n) when n > 0 do c(1, n) end

	defp c(n, n) do [n] end
	defp c(i, n) do
		[i|c(i+1, n)]
	end
end