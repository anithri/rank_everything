class RankedListsController < ApplicationController
  before_action :set_ranked_list, only: %i[ show edit update destroy ]
  before_action :set_team, only: %i[ new create index]

  # GET /ranked_lists or /ranked_lists.json
  def index
    @ranked_lists = policy_scope @team.ranked_lists.all

    add_breadcrumb "Teams", teams_path
    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb "Ranked Lists", team_ranked_lists_path(@team)
  end

  # GET /ranked_lists/1 or /ranked_lists/1.json
  def show
    authorize @ranked_list

    add_breadcrumb "Teams", teams_path
    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb "Ranked Lists", team_ranked_lists_path(@team)
    add_breadcrumb @ranked_list.name, ranked_list_path(@team)
  end

  # GET /team/1/ranked_lists/new
  def new
    @ranked_list = @team.ranked_lists.build
    authorize @ranked_list

    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb "Ranked Lists", team_ranked_lists_path(@team)
    add_breadcrumb "New", new_team_ranked_list_path(@team)
  end

  # GET /ranked_lists/1/edit
  def edit
    authorize @ranked_list

    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb "Ranked Lists", team_ranked_lists_path(@team)
    add_breadcrumb @ranked_list.name, ranked_list_path(@ranked_list)
    add_breadcrumb "edit", edit_ranked_list_path(@ranked_list)
  end

  # POST /ranked_lists or /ranked_lists.json
  def create
    @ranked_list = RankedList.new(team: @team, **ranked_list_params)
    authorize @ranked_list

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
    authorize @ranked_list

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
    authorize @ranked_list

    @ranked_list.destroy!

    respond_to do |format|
      format.html { redirect_to team_ranked_lists_path(@team), status: :see_other, notice: "Ranked list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ranked_list
    @ranked_list = RankedList.includes(team: { memberships: :user }).find(params.expect(:id))
    @team = @ranked_list.team
  end

  def set_team
    @team = Team.includes(memberships: :user).find(params[:team_id])
  end

  # Only allow a list of trusted parameters through.
  def ranked_list_params
    params.expect(ranked_list: [ :name, :description, :ranking_method, :visible, :items_count, :votes_count ])
  end
end
