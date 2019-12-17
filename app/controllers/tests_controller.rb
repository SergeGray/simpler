class TestsController < Simpler::Controller

  def index
    @time = Time.now
  end

  def create; end
  
  def plain
    render plain: "What's up"
  end
end
