class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = Order.includes(:promotion, order_items: :product)
                   .order(created_at: :desc)
  end

  def show
  end

  def new
    @order = Order.new(status: :draft)
    build_item_slots
  end

  def edit
    build_item_slots
  end

  def create
    @order = Order.new(order_params)
    @order.recalculate_totals

    if @order.save
      redirect_to @order, notice: "สร้างออเดอร์เรียบร้อยแล้ว"
    else
      build_item_slots
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @order.assign_attributes(order_params)
    @order.recalculate_totals

    if @order.save
      redirect_to @order, notice: "อัปเดตออเดอร์เรียบร้อยแล้ว", status: :see_other
    else
      build_item_slots
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy!
    redirect_to orders_path, notice: "ลบออเดอร์เรียบร้อยแล้ว", status: :see_other
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def build_item_slots
    [3 - @order.order_items.size, 0].max.times do
      @order.order_items.build
    end
  end

  def order_params
    params.require(:order).permit(
      :customer_name,
      :status,
      :promotion_id,
      order_items_attributes: %i[id product_id quantity _destroy]
    )
  end
end
