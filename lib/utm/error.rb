# frozen_string_literal: true

class Utm::Error < StandardError
	def text
		raise NotImplementedError
	end
	
	def to_s
		super == self.class.to_s ? text : super
	end
end
