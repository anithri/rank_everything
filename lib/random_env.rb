# frozen_string_literal: true
require 'faker'

module RandomEnv
    TOKEN_CHARS = [ 2, 3, 4, 6, 7, 9, ("a".."z").to_a, ("A".."Z").to_a ].flatten.freeze

    def self.token(new_password = nil, length = 16)
      return new_password if new_password
      length.times.each_with_object([]) { |_, a| a << TOKEN_CHARS.sample }.join
    end

    def self.port(from = 49152, to = 65535)
      rand(from..to)
    end

    def self.username(name = nil)
      return name if name
      [ Faker::Internet.username,
        Faker::Fantasy::Tolkien.character,
        Faker::Movies::StarWars.character,
        Faker::TvShows::DrWho.character,
        Faker::TvShows::StarTrek.character
      ].sample.gsub(/\s+/,"")
    end

    def self.secret_key_base
      `rails secret`.strip
    end
  end

