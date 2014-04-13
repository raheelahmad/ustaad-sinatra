module MyApp
  class JSONType
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      headers["Content-Type"] = 'application/json'
      [status, headers, response]
    end
  end
end

