class PurchasesController < ApplicationController
    def new
      @purchase = Purchase.new
      @groups = current_user.groups
    end
  
    def create
      @purchase = current_user.purchases.new(purchase_params)
      @groups = current_user.groups
  
      if params[:purchase][:group_ids].nil?
        redirect_to new_group_purchase_path(params[:group_id]), alert: 'You should select at least one group.'
        return
      end
  
      params[:purchase][:group_ids].each do |group|
        @purchase.groups << @groups.find { |g| g.id == group.to_i }
      end
  
      respond_to do |format|
        if @purchase.save
          format.html { redirect_to group_path(params[:group_id]), notice: 'Transaction was successfully created.' }
        else
          flash.now[:alert] = @purchase.errors.full_messages.join(', ')
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end
  
    private
  
    def purchase_params
      params.require(:purchase).permit(:name, :amount)
    end
  end