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

  post '/figures' do
    @figure = Figure.create(name: params[:figure][:name])
      if params.has_key?(:title_ids)
        @title = Title.find(params[:figure][:title_ids])
          if Title.all.find(params[:figure][:title_ids]) && !@figure.titles.include?(@title)
            @figure.titles << Title.find(params[:figure][:title_ids])
          end
      end
        if params[:title][:name] != nil
          @new_title = Title.create(name: params[:title][:name])
          @new_title.save
          @figure.titles << @new_title
        end
      if params.has_key?(:landmark_ids)
        @landmark = Landmark.find(params[:landmark_ids])
            if Landmark.all.find(params[:landmark_ids]) && !@figure.landmarks.include?(@landmark)
              @figure.landmarks << @landmark
            end
      end
        if params[:landmark][:name] != nil
          @new_landmark = Landmark.create(name: params[:landmark][:name])
          @new_landmark.save
          @figure.landmarks << @new_landmark
        end
    @figure.save

    redirect to :"figures/show"
  end
end
