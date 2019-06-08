class FiguresController < ApplicationController
  set :views, proc { File.join(root, '../views/') }

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
      @titles = Title.all
      @landmarks = Landmark.all
      erb :"figures/new"
  end

  post '/figures/new' do
    binding.pry

    redirect to :"figures/show"
  end
end
