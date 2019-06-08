class FiguresController < ApplicationController
  set :views, proc { File.join(root, '../views/') }

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end
end
