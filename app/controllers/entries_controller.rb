class EntriesController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @entries = Entry.all
    if title = params[:title]
      @entries = @entries.where(title: title)
    end
    render json: @entries, status: 200
  end

  def show
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      render json: @entry, status: 200
    else
      render json: @entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.json { render :show, status: :ok, location: @entry }
      else
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:title)
    end
end
