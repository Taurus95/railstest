require 'fancy'

class Fancifier
	include Fancy
	attr_accessor :title

	def initialize(title)
		@title = title

		#at the moment of create an object i add singlenton methods to this depending of the db, for each color
		colors = Color.all
		colors.each do |c|
			self.send(:define_singleton_method, c.name) { return c.code }
		end

	end

	def method_missing(name, *args, &block)
	end

	def respond_to_missing(name, *args)
		name = name || super
	end

	#
	# Transform a word to palindrome
	#
	def makePalindrome(text)
        palindrome = text + text.reverse
        return palindrome
    end

	#
	# Return boolean if a complete word is palindrome
	#
    def detectPalindrome(text)
        if text.reverse == text
            true
        else
            false
    	end

	end

	#
	# Detect the largest palindrome in a word
	#
	def longestPalindrome(text)
  		arr = text.downcase.chars
  		text.length.downto(1) do |n|
    		ana = arr.each_cons(n).find { |b| b == b.reverse }
    		return ana.join if ana
  		end
	end

	#
	# return the code of a color, was just for try in the beginig
	#
    def colorToCode(text)
        color = Color.find_by name: text
        return color.code
	end

	# def setColors()
	# 	colors = Color.all
	# 	colors.each do |c|
	# 		self.send(:define_singleton_method, c.name) { puts c.code }
	# 	end
    # end

end
