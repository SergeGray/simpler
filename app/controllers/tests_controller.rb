class TestsController < Simpler::Controller

  def index
    @time = Time.now
    @tests = Test.all
  end

  def create; end
  
  def plain
    render plain: "What's up"
    status 202
    headers['Content-Type'] = 'text/plain'
  end

  def show
    @id = params[:id]
  end
end
