class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    # Retrieve user input from params
    m = Actor.new
    m.name = params.fetch("query_name")
    m.dob = params.fetch("query_dob")
    m.bio = params.fetch("query_bio")
    m.image = params.fetch("query_image")

    m.save

    redirect_to("/actors")
    # Create record in movie table
    # Populate each column with user input

    return
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_records = Actor.where({:id=> the_id})
    the_actor = matching_records.at(0)
    the_actor.destroy

    redirect_to("/actors")
  end


  def update
    d_id = params.fetch("the_id")
    matching_records = Actor.where({:id=> d_id})
    the_actor = matching_records.at(0)

    the_actor.name = params.fetch("query_name")
    the_actor.dob = params.fetch("query_dob")
    the_actor.bio = params.fetch("query_bio")
    the_actor.image = params.fetch("query_image")
    
    the_actor.save

    redirect_to("/actors/#{the_actor.id}")
  end
end
