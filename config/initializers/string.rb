class String
	def is_on_edge_of(string)
		return (string.index(" #{self}") == (string.length - " #{self}".length)) || (string.index("#{self} ") == 0)
	end
end