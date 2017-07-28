ActiveAdmin.register OldSalt do
  action_item do
    link_to 'Invite OldSalt', new_invitation_admin_old_salts_path
  end

  collection_action :new_invitation do
    @old_salt = OldSalt.new
  end
  permit_params :first_name, :last_name, :email

  collection_action :send_invitation, method: :post do
    @old_salt = OldSalt.invite!(permitted_params[:old_salt], current_old_salt)
    if @old_salt.errors.empty?
      redirect_to admin_old_salts_path, notice: "Old Salt has been successfully invited."
    else
      messages = @old_salt.errors.full_messages.map { |msg| msg }.join
      redirect_to new_invitation_admin_old_salts_path, alert: "Error: " + messages
    end
  end

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :phone_no
    column :invitation_sent_at
    column :invitation_accepted_at
    column :sign_in_count
    column :current_sign_in_at
    column :last_sign_in_at
    actions
  end

end
