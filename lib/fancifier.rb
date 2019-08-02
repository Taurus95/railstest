require 'fancy'

class Fancifier
	include Fancy
	attr_accessor :title

	def initialize(title)
		@title = title
	end

	def method_missing(name)
		name = name.gsub(/\s+/, "")
		name2 = name.reverse
		name = name + name2
		return name
	end

	def respond_to_missing(name, *args)
		name = name || super
	end


end

