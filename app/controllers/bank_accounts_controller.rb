class BankAccountsController < ApplicationController
  before_action :authenticate_old_salt!

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

end
