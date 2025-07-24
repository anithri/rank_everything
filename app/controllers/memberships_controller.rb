class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[ show edit update destroy ]
  before_action :set_team, only: %i[ index new create ]

  # GET /memberships or /memberships.json
  def index
    @memberships = policy_scope @team.memberships.includes(:user).order("role desc", "users.name")

    add_breadcrumb "Teams", teams_path
    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb "Memberships", team_memberships_path(@team)
  end

  # GET /memberships/1 or /memberships/1.json
  def show
    authorize @membership

    add_breadcrumb "Teams", teams_path
    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb "Memberships", team_memberships_path(@team)
    add_breadcrumb @membership.user.name, membership_path(@membership)
  end

  # GET /memberships/new
  def new
    @membership = @team.memberships.build
    authorize @membership

    add_breadcrumb "Teams", teams_path
    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb "Memberships", team_memberships_path(@team)
    add_breadcrumb "new", new_team_membership_path(@team)
  end

  # GET /memberships/1/edit
  def edit
    authorize @membership

    add_breadcrumb "Teams", teams_path
    add_breadcrumb @team.name, team_path(@team)
    add_breadcrumb "Membership", team_memberships_path(@team)
    add_breadcrumb "edit", edit_membership_path(@team)
  end

  # POST /memberships or /memberships.json
  def create
    @membership = @team.memberships.build(membership_params)
    authorize @membership

    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership, notice: "Membership was successfully created." }
        format.json { render :show, status: :created, location: @membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
    authorize @membership

    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1 or /memberships/1.json
  def destroy
    authorize @membership
    @membership.destroy!

    respond_to do |format|
      format.html { redirect_to team_memberships_path(@team), status: :see_other, notice: "Membership was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.includes(:user, :team).find(params.expect(:id))
    @team = @membership.team
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  # Only allow a list of trusted parameters through.
  def membership_params
    params.expect(membership: [:team_id, :user_id, :role])
  end
end
