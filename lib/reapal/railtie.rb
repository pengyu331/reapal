module Reapal
  class Railtie < ::Rails::Railtie
    initializer "Reapal.logger" do
      Reapal.logger = Rails.logger
    end
  end
end
