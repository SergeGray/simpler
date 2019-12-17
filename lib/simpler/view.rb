require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def self.render_static(page)
      File.read(Simpler.root.join('public', page))
    end

    def initialize(env)
      @env = env
    end

    def render(binding)
      if format
        [nil, send(format, value)]
      else
        template = File.read(template_path(path_string))
        [path_string, ERB.new(template).result(binding)]
      end
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def format
      @env['simpler.format']
    end

    def value
      @env['simpler.value']
    end

    def plain(text)
      text
    end

    def path_string
      path = template || [controller.name, action].join('/')
      
      "#{path}.html.erb"
    end

    def template_path(string)
      Simpler.root.join(VIEW_BASE_PATH, string)
    end
  end
end
