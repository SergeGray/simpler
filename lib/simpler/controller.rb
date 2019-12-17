require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action, route_params)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action
      @request.env['simpler.route_params'] = route_params

      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    def not_found
      set_default_headers
      status(404)
      @response.write(render_static('404.html'))
      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def params
      @request.env['simpler.route_params']
    end

    def render(params = {})
      if params.is_a?(Hash)
        params.each do |format, value|
          @request.env['simpler.format'] = format
          @request.env['simpler.value'] = value
        end
      else
        @request.env['simpler.template'] = params
      end
    end

    def status(code)
      @response.status = code
    end

    def headers
      @response.headers
    end

    def render_static(page)
      View.render_static(page)
    end
  end
end
