# frozen_string_literal: true

class EnvCheck
  attr_reader :names

  def initialize(*names)
    @names = names.flatten
  end

  def check(env)
    missing = names.each_with_object([]) do |name, missing|
      (missing << item) if env[name].nil?
    end

    return true if missing.empty?

    raise "Missing from ENV: #{missing.join(' ')}"
  end
end
