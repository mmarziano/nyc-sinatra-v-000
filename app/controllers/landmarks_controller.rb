class LandmarksController < ApplicationController
  # add controller methods
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :"landmarks/index"
  end

  get '/landmarks/new' do
      @landmarks = Landmark.all
      erb :"landmarks/new"
  end

  post '/landmarks' do
    #binding.pry
    @landmark = Landmark.create(name: params[:landmark][:name])
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

    redirect to :"landmarks/show"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @figures = @landmark.figure


    erb :"landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])

    erb :'landmarks/edit'
  end

  patch '/landmarks/:id' do
    binding.pry

    redirect to :"landmarks/#{@landmark.id}"
  end
end
