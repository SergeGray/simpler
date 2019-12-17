class TestsController < Simpler::Controller

  def index
    @time = Time.now
  end

  def create; end
  
  def plain
    render plain: "What's up"
    status 202
    headers['Content-Type'] = 'text/plain'
  end
end
