# frozen_string_literal: true

module SystemAdmin
  class ProvidersController < ApplicationController
    def index
      @providers = authorize Provider.all.order(:name)
    end

    def new
      @provider = authorize Provider.new
    end

    def create
      @provider = authorize Provider.new(provider_params)

      if @provider.save
        redirect_to providers_path
      else
        render :new
      end
    end

    def show
      @provider = authorize Provider.find(params[:id])
      @users_view = UsersView.new(@provider)
    end

  private

    def provider_params
      params.require(:provider).permit(:name, :dttp_id, :code, :apply_sync_enabled)
    end
  end
end
