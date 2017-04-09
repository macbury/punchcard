# frozen_string_literal: true

class Db
  extend Forwardable
  include Singleton

  delegate [:[]] => :@database

  def initialize
    @database = Daybreak::DB.new(File.join('db', "#{RACK_ENV}.db"))
  end

  def safe_push(key, value)
    @database.synchronize do
      data = @database[key] || []
      data << value
      @database[key] = data
      @database.flush
    end
  end

  def teardown
    @database.flush
    @database.close
  end
end
