class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update ]

  # GET /teams or /teams.json
  def index
    @teams = policy_scope(Team.includes(:memberships))

    add_breadcrumb "Teams", teams_path
  end

  # GET /teams/1 or /teams/1.json
  def show
    authorize @team
    flash[:notice] = "Wooticus Prime!!!"
    flash[:alert] = "WooHoo"
    add_breadcrumb "Teams", teams_path
    add_breadcrumb @team.name, team_path(@team)
  end

  # GET /teams/new
  def new
    @team = Team.new
    authorize @team

    add_breadcrumb "Teams", teams_path
    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb "new", new_team_path
  end

  # GET /teams/1/edit
  def edit
    authorize @team

    add_breadcrumb "Teams", teams_path
    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb "edit", edit_team_path(@team)
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)
    authorize @team

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    authorize @team

    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.includes(memberships: :user).find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def team_params
    params.expect(team: [ :name, :description, :visible, :owner_id ])
  end
end
