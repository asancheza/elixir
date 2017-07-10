defmodule Temp do
	@moduledoc """
	This is a temp module
	"""

 	@doc "Convert to C" 
 	def convert({:c, value}) do
		5 * (value - 32) / 9 
	end

	@doc "Convert to F" 
 	def convert({:f, value}) do
		(9 * value / 5) - 32
	end
end