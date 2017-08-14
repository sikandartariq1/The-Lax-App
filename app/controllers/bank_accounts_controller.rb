class BankAccountsController < ApplicationController
  before_action :authenticate_old_salt!
  before_action :set_account, only: [:edit, :update, :show]

  def new
  end

  def create
    begin
      StripeManagedAccount.new(params, current_old_salt, request.remote_ip).create_account
      redirect_to old_salt_bank_account_path(current_old_salt), notice: 'Account created'
    rescue => ex
      flash.now[:errors] = ex.to_s
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    begin
      StripeManagedAccount.new(params, current_old_salt, request.remote_ip).update_account
      redirect_to old_salt_bank_account_path(current_old_salt), notice: 'Account Updated'
    rescue => ex
      flash.now[:errors] = ex.to_s
      render 'edit'
    end
  end

  private

    def set_account
      @account = StripeManagedAccount.new(params, current_old_salt, request.remote_ip).find_stripe_account
      redirect_to new_old_salt_bank_account_path(current_old_salt), notice: 'Please create an account first' if @account.blank?
    end

end
