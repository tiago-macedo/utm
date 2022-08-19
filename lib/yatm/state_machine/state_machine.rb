# frozen_string_literal: true

require_relative "state_machine_errors"
require_relative "event"

class YATM::StateMachine
  attr_reader :current_state, :events, :final_states, :initial_state

  def initialize
    @events = {}
    @final_states = []
  end

  def reset
    @current_state = @initial_state
  end

  def to_s
    <<~TO_S.chomp
      | states:  #{states}
      | current: #{@current_state}
      | events: #{@events.map(&:name)}
    TO_S
  end

  def states
    @events.map do |_name, event|
      event.keys + event.map { |_, val| val[:to] }
    end.flatten.uniq
  end

  def initial_state(state)
    @initial_state = self.class.statify(state)
    @current_state = @initial_state
  end

  def final_state(*states)
    states.each do |state|
      (@final_states << self.class.statify(state)).uniq!
    end
  end

  def event(name, **transitions)
    @events[name] = YATM::Event.new(name, **transitions)
  end

  def process(value)
    process!(value)
  rescue StateMachineError
    nil
  end

  def process!(value)
    return { final: @current_state } if @final_states.include?(@current_state)
    raise InitialStateNotSet unless @current_state
    raise InvalidEvent, value unless (event = @events[value])
    raise InvalidTransition.new(@current_state, event) unless (
      transition = event[@current_state] || event[YATM::ANY]
    )

    @current_state = transition[:to] unless transition[:to] == YATM::SAME
    transition
  end

  def self.statify(state)
    raise InvalidState, state unless state.respond_to?(:to_s)

    state = state.to_s
    raise InvalidState, state unless state.respond_to?(:to_sym)

    state.to_sym
  end
end
