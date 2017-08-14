module BankAccountsHelper

  def set_address(account, attribute)
    return unless account.present? && account.legal_entity.present? && account.legal_entity.address.present?
    account.legal_entity.address.send(attribute)
  end

  def set_legal_entity(account, attribute)
    return unless account.present? && account.legal_entity.present?
    account.legal_entity.send(attribute)
  end

end
