module Fog
  module Identity

    def self.[](provider)
      self.new(:provider => provider)
    end

    def self.new(attributes)
      # attributes = attributes.dup # Prevent delete from having side effects
      # case provider = attributes.delete(:provider).to_s.downcase.to_sym
      # if self.providers.include?(provider)
      #   require "fog/#{provider}/identity"
      #   return Fog::Identity.const_get(Fog.providers[provider]).new(attributes)
      # end
      # raise ArgumentError.new("#{provider} has no identity service")
      return Fog::Identity::V2::OpenStackCommon.new(attributes)
    end

    def self.providers
      Fog.services[:identity]
    end

  end
end
