class TadpolesController < ApplicationController
  before_action :find_tadpole, only: [:show, :edit, :update, :destroy, :metamorphosize]

   def metamorphosize
      # raise params.inspect
      @frog= Frog.new(set_frog_params(@tadpole))
      if @frog.save
           @tadpole.destroy
           redirect_to @frog, notice: 'Tadpole successfully became a Frog.'
      else
        format.html { render :show }
      end
  end
  
  def index
    @tadpoles = Tadpole.all
  end

  def show
  end

  def new
    @frog = Frog.find(find_frog)
    @tadpole = Tadpole.new
  end

  def edit
    @frog = @tadpole.frog
  end

  def create
    @tadpole = Tadpole.new(tadpole_params)
    respond_to do |format|
      if @tadpole.save
        format.html { redirect_to @tadpole, notice: 'Tadpole was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tadpole.update(tadpole_params)
        format.html { redirect_to @tadpole, notice: 'Tadpole was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @tadpole.destroy
    respond_to do |format|
      format.html { redirect_to tadpoles_url, notice: 'Tadpole was successfully destroyed.' }
    end
  end

  private
    def find_tadpole
      @tadpole = Tadpole.find(params[:id])
    end

    def find_frog
      @frog = Frog.find(params[:frog_id])
    end

    def tadpole_params
      params.require(:tadpole).permit(:name, :color, :frog_id)
    end

    def set_frog_params(tadpole)
      {name: tadpole.name , color: tadpole.color, pond_id: tadpole.pond.id }
    end
end
