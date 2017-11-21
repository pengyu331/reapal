module Reapal
  class Railtie < ::Rails::Railtie
    initializer "reapal.logger" do
      Reapal.logger = Rails.logger
    end
  end
end
