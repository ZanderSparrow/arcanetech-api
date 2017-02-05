class EntriesController < ApplicationController
  def index
    entries = Entry.all
    render json: entries, status: 200
  end
end
