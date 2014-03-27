module Fog
  module Identity

    def self.[](provider)
      self.new(:provider => provider)
    end

    # def self.new(attributes)
    #   # attributes = attributes.dup # Prevent delete from having side effects
    #   # case provider = attributes.delete(:provider).to_s.downcase.to_sym
    #   # if self.providers.include?(provider)
    #   #   require "fog/#{provider}/identity"
    #   #   return Fog::Identity.const_get(Fog.providers[provider]).new(attributes)
    #   # end
    #   # raise ArgumentError.new("#{provider} has no identity service")
    #   require "fog/openstackcommon/identity_v2"
    #   return Fog::Identity::V2::OpenStackCommon.new(attributes)
    # end

    def self.new(attributes)

      puts "ATTRIBUTES: #{attributes.to_yaml}"
      puts "self.providers: #{self.providers.to_yaml}"
      puts "Fog.providers: #{Fog.providers.to_yaml}"

      attributes = attributes.dup # Prevent delete from having side effects
      provider = attributes.delete(:provider).to_s.downcase.to_sym
      puts "PROVIDER: #{provider}"

      unless self.providers.include?(provider)
        raise ArgumentError.new("#{provider} has no identity service")
      end

      require "fog/#{provider}/identity"
      begin
        puts "Inside BEGIN"
        Fog::Identity.const_get(Fog.providers[provider]).new(attributes)
      rescue
        puts "Inside RESCUE"
        Fog::const_get(Fog.providers[provider]).const_get("Identity").new(attributes)
      end
    end

    def self.providers
      Fog.services[:identity]
    end

  end
end
