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

  def show
    account = Account.find_by(id: params[:id])
    render json: account, status: :ok,
      serializer: Accounts::Show::AccountsSerializer
  end

  def deposit
    account = Account.find(params[:id])
    account.balance = account.balance += value_typed.to_f
    account.save!
    render json: { mensage: "deposited" }, status: :ok
  end

  def withdraw
    account = Account.find(params[:id])
    account.balance = account.balance -= value_typed.to_f
    account.save!
    render json: { mensage: "withdrawn" }, status: :ok
  end

  def transfer
    transfer_command = TransferOperation.new(params)
    transfer_command.on(:success) do |mensage|
      render json: { mensage: "transfer completed" }, status: :ok
    end
    transfer_command.on(:failed) do |errors|
      render json: { errors: "transfer not completed" }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:account).permit(:name, :balance, :user_id)
  end

  def update_params
    params.require(:account).permit(:name, :balance, :user_id)
  end

  def value_typed
    params[:value]
  end
end
