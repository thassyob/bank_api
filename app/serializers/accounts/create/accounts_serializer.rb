class Accounts::Create::AccountsSerializer < ActiveModel::Serializer
  attributes :id, :name, :balance

  belongs_to :user, serializer: Accounts::Create::UsersSerializer
end
