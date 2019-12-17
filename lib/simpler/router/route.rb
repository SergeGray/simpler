module Simpler
  class Router
    class Route

      attr_reader :controller, :action

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && path.match(path_regex)
      end

      def path_regex
        @path.gsub(/:[a-z]+/, '\d+')
      end

      def params(env)
        path = env['PATH_INFO']
        param_keys = @path.scan(/:([a-z]+)/).map { |group| group.first.to_sym }
        param_values = path.scan(/\d+/)
        return unless param_keys

        Hash[param_keys.zip(param_values)]
      end
    end
  end
end
