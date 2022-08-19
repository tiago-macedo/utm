# frozen_string_literal: true

require_relative "../error"

class TapeError < YATM::Error; end

class InvalidMove < TapeError
  def text; "Invalid argument for method YATM::Tape#move"; end
end
