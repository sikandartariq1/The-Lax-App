class StripeManagedAccount
  attr_reader :params, :old_salt, :account, :remote_ip

  def initialize(params, old_salt, remote_ip)
    @params = params
    @old_salt = old_salt
    @remote_ip = remote_ip
  end

  def create_account
    stripe_account
    dob
    address
    legal_entity
    tos_acceptance
    external_account
    account.save
    old_salt.update(stripe_account_id: account.id)
  end

  private

    def stripe_account
      @account = Stripe::Account.create({
          country: params[:country],
          type: "custom"
      })
    end

    def legal_entity
      account.legal_entity.personal_id_number = params[:social_security_number]
      account.legal_entity.type = 'individual'
      legal_name
    end

    def legal_name
      account.legal_entity.first_name = params[:first_name]
      account.legal_entity.last_name = params[:last_name]
    end

    def tos_acceptance
      account.tos_acceptance.date = Time.now.to_i
      account.tos_acceptance.ip = remote_ip
    end

    def dob
      account.legal_entity.dob = {
        day: params[:date_of_birth]["date_of_birth(3i)"],
        month: params[:date_of_birth]["date_of_birth(2i)"],
        year: params[:date_of_birth]["date_of_birth(1i)"],
      }
    end

    def address
      account.legal_entity.address = {
        city: params[:address_city],
        line1: params[:address_street],
        postal_code: params[:address_zip],
        state: params[:address_state],
        country: params[:country]
      }
    end

    def external_account
      account.external_accounts.create(
        external_account:{
          object: :bank_account,
          account_number: params[:account_number],
          routing_number: params[:routing_number],
          country: params[:country],
          currency: :USD
      })
    end

end
