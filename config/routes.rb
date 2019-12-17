Simpler.application.routes do
  get '/tests/plain', 'tests#plain'
  get '/tests', 'tests#index'
  post '/tests', 'tests#create'
end
