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
    binding.pry
    @figure = Figure.create(name: params[:figure])
      if params[:landmark][:name]
        @figure.landmarks << Landmark.create(params[:landmark])
      end
      if params[:title][:name]
        @figure.titles << Title.create(params[:title])
      end
      #if params.has_key?(:title_ids)
        #@figure.titles.clear
        #@title = Title.find(params[:figure][:title_ids])
          #if !@figure.titles.include?(@title)
            #@figure.titles = @title
          #end
      #end
      #   if params[:title][:name] != nil
      #     @new_title = Title.create(name: params[:title][:name])
      #     @new_title.save
      #     @figure.titles << @new_title
      #   end
      # if params.has_key?(:landmark_ids)
      #   @landmark = Landmark.find(params[:figure][:landmark_ids])
      #       if !@figure.landmarks.include?(@landmark)
      #         @figure.landmarks << @landmark
      #       end
      # end
      #   if params[:landmark][:name] != ""
      #     @new_landmark = Landmark.create("name" => params[:landmark][:name], "year_completed" => params[:landmark][:year_completed])
      #     @new_landmark.save
      #     @figure.landmarks << @new_landmark
      #   end
      @figure.save

    redirect to "figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @landmarks = @figure.landmarks
    @titles = @figure.titles

    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = @figure.landmarks
    @titles = @figure.titles
    erb :'figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])

    @figure.update("name" => params[:figure][:name])
    @figure.titles.clear
      if params[:figure][:title_ids] != ""
        @title = Title.find(params[:figure][:title_ids])
          if Title.all.find(params[:figure][:title_ids]) && !@figure.titles.include?(@title)
            @figure.titles << Title.find(params[:figure][:title_ids])
          end
      end
        if params[:title][:name] != ""
          @new_title = Title.create(name: params[:title][:name])
          @new_title.save
          @figure.titles << @new_title
        end
      @figure.landmarks.clear
      if params[:figure][:landmark_ids] != ""
        @landmark = Landmark.find(params[:figure][:landmark_ids])
            if !@figure.landmarks.include?(@landmark)
              @figure.landmarks << @landmark
            end
      end
        if params[:landmark][:name] != ""
          @new_landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
          @new_landmark.save
          @figure.landmarks << @new_landmark
        end
    @figure.save
    #binding.pry
    redirect to :"figures/#{@figure.id}"
  end
end
