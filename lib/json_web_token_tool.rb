
class JsonWebTokenTool
  SECRET_KEY = ENV['JSON_WEB_TOKEN_SECRET_KEY']

  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i

      JWT.encode(payload, SECRET_KEY)
    end

    def decode(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]

      HashWithIndifferentAccess.new decoded
    end
  end
end