class RankedListsController < ApplicationController
  before_action :set_ranked_list, only: %i[ show edit update destroy ]

  # GET /ranked_lists or /ranked_lists.json
  def index
    @ranked_lists = RankedList.all
  end

  # GET /ranked_lists/1 or /ranked_lists/1.json
  def show
  end

  # GET /ranked_lists/new
  def new
    @ranked_list = RankedList.new
  end

  # GET /ranked_lists/1/edit
  def edit
  end

  # POST /ranked_lists or /ranked_lists.json
  def create
    @ranked_list = RankedList.new(ranked_list_params)

    respond_to do |format|
      if @ranked_list.save
        format.html { redirect_to @ranked_list, notice: "Ranked list was successfully created." }
        format.json { render :show, status: :created, location: @ranked_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ranked_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ranked_lists/1 or /ranked_lists/1.json
  def update
    respond_to do |format|
      if @ranked_list.update(ranked_list_params)
        format.html { redirect_to @ranked_list, notice: "Ranked list was successfully updated." }
        format.json { render :show, status: :ok, location: @ranked_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ranked_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ranked_lists/1 or /ranked_lists/1.json
  def destroy
    @ranked_list.destroy!

    respond_to do |format|
      format.html { redirect_to ranked_lists_path, status: :see_other, notice: "Ranked list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ranked_list
      @ranked_list = RankedList.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def ranked_list_params
      params.expect(ranked_list: [ :name, :description, :ranking_method, :team_id, :visible, :items_count, :votes_count ])
    end
end
