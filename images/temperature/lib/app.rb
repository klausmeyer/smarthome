module Fritzbox::Smarthome
  TEMP_VALUE_OFF = 126.5
end

class App < Rack::App
  headers 'Content-Type' => 'text/plain; charset=utf8'
  get '/' do
    'Hello'
  end

  get '/metrics' do
    Fritzbox::Smarthome::Actor.all.map do |actor|
      value_is  = actor.hkr_temp_is
      value_set = actor.hkr_temp_set == Fritzbox::Smarthome::TEMP_VALUE_OFF ? 0.0 : actor.hkr_temp_set

      name = actor.name.tr('"', '')
      [
        %Q(temperature_#{actor.type}_is{actor="#{name}"} #{value_is}),
        %Q(temperature_#{actor.type}_set{actor="#{name}"} #{value_set})
      ]
    end.flatten.join("\n")
  rescue => e
    Rollbar.error(e)
    raise
  end
end
