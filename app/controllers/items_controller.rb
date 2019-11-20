class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def update
    @item = Item.find_by_id(params[:id])
    return render_not_found if @item.blank?
    @item.update_attributes(item_params)
    
    if @item.valid?
       redirect_to root_path
    else
       return render :edit, status: :unprocessable_entity
     end
  end

  def destroy
    @item = Item.find_by_id(params[:id])
    return render_not_found if @item.blank?
    @item.destroy
    redirect_to root_path
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find_by_id(params[:id])
    return render_not_found if @item.blank?
  end

  def edit
    @item = Item.find_by_id(params[:id])
    return render_not_found if @item.blank?
  end

  def index
  end

  def create
    @item = current_user.items.create(item_params)
    if @item.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:title)
  end

  def render_not_found
    render plain: 'Not Found :(', status: :not_found
  end

end
