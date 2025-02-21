class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    # Retrieve user input from params
    m = Director.new
    m.name = params.fetch("query_name")
    m.dob = params.fetch("query_dob")
    m.bio = params.fetch("query_bio")
    m.image = params.fetch("query_image")

    m.save

    redirect_to("/directors")
    # Create record in movie table
    # Populate each column with user input

    return
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Director.where({:id=> the_id})
    
    the_director = matching_records.at(0)

    the_director.destroy

    redirect_to("/directors")
  end


  def update
    m_id = params.fetch("the_id")

    matching_records = Movie.where({:id=> m_id})
    
    the_movie = matching_records.at(0)

    the_movie.title = params.fetch("the_title")
    the_movie.year = params.fetch("the_year")
    the_movie.duration = params.fetch("the_duration")
    the_movie.description = params.fetch("the_description")
    the_movie.image = params.fetch("the_image")
    the_movie.director_id = params.fetch("the_director_id")
    
    the_movie.save

    redirect_to("/movies/#{the_movie.id}")
  end
end
