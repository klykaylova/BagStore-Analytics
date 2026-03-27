class ProductsController < ApplicationController
  def index
    @categories = Category.all

    # стартовий запит
    @products = Product.all

    # 🔹 Фільтрація за категорією
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # 🔹 Сортування
    @products =
      case params[:sort]
      when "cheap_first"
        @products.order(price: :asc)
      when "expensive_first"
        @products.order(price: :desc)
      when "newest"
        @products.order(created_at: :desc)
      else
        @products.order(created_at: :asc)
      end

    # 🔹 Пагінація → 8 товарів на сторінку (2 ряди по 4)
    @products = @products.page(params[:page]).per(8)

    # --- ЛОГУВАННЯ АКТИВНОСТІ (Частина 2) ---
    Rails.logger.info "--- [BagStore] Користувач переглянув каталог ---"
    Rails.logger.info "[BagStore] Сортування: #{params[:sort] || 'за замовчуванням'}"
    if params[:category_id].present?
      Rails.logger.info "[BagStore] Обрана категорія ID: #{params[:category_id]}"
    end
  end

  def show
    @product = Product.find(params[:id])
    
    # --- ЛОГУВАННЯ АКТИВНОСТІ (Частина 2) ---
    # Цей рядок має бути ВСЕРЕДИНІ методу show
    Rails.logger.info "[BagStore] Перегляд товару: #{@product.name} (ID: #{@product.id})"
  end
end