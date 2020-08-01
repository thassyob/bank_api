class AccountsController < ApplicationController
skip_before_action :verify_authenticity_token

  def create
   account = Account.create!(create_params)
   render json: account, status: :created,
     serializer: Accounts::Create::AccountsSerializer
  end

  def update
    account = Account.find(params[:id])
    account.update!(update_params)
    head :no_content
  end

  def deposit
    account = Account.find(params[:id])
    account.balance = account.balance += valor_deposited.to_f
    account.save!
    render json: { mensage: "deposited" }, status: :ok
  end

  private

  def create_params
    params.require(:account).permit(:name, :balance, :user_id)
  end

  def update_params
    params.require(:account).permit(:name, :balance, :user_id)
  end

  def valor_deposited
    params[:value]
  end
end
