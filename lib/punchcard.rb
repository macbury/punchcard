# frozen_string_literal: true
require_relative 'db'
require 'rack/app/front_end'

class Punchcard < Rack::App
  apply_extensions :front_end

  at_exit do
    Db.instance.teardown
  end

  def punch_key
    params['punch_key']
  end

  def name
    params['name']
  end

  def current_stats
    Db.instance[Settings.events.to_h[name.to_sym].to_s]
  end

  get '/p/:punch_key' do
    if Settings.events.to_h.values.include?(punch_key)
      Db.instance.safe_push(punch_key, Time.now)
      'YUP'
    else
      'NOPE'
    end
  end

  next_endpoint_middlewares do |builder|
    builder.use Rack::Auth::Basic, 'Restricted Area' do |username, password|
      [username, password] == [Settings.admin_username, Settings.admin_password]
    end
  end

  get '/stats/:name' do
    if Settings.events.to_h.keys.include?(name.to_sym)
      @stats = current_stats
      @name = name
      render '/views/stats.html.haml'
    else
      'NOPE'
    end
  end
end
