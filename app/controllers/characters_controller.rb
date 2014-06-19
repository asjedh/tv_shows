class CharactersController < ApplicationController

  def new
    @show = TelevisionShow.find(params[:television_show_id])
    @character = Character.new()
  end

  def create
    @character = Character.new(character_params)
    @character.television_show_id = params[:television_show_id]
    @show = TelevisionShow.find(params[:television_show_id])

    if @character.save
      flash[:notice] = "Success"
      # you need the return!
      return redirect_to television_show_path(params[:television_show_id])
    else
      # note that flash.now is only used when rendering,
      # not when directing
      flash.now[:notice] = "Your character couldn't be saved."
      render :new
    end

  end

  def index
    @characters = Character.all
  end

  def destroy
    @character = Character.find(params[:id])
    @character_name = @character.character_name
    @character.destroy
    flash[:notice] = "#{@character_name} has been deleted!"
    redirect_to characters_path
  end

  private

  def character_params
    params.require(:character).permit(:character_name, :actor_name, :description)
  end
end
