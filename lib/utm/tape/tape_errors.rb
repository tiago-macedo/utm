# frozen_string_literal: true

require_relative "../error"

class TapeError < UTM::Error; end

class InvalidMove < TapeError
	def text; "Invalid argument for method UTM::Tape#move"; end
end
