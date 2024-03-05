# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %i[show edit update destroy]

  def index
    @quotes = current_company.quotes.ordered
  end

  def show
    @line_item_dates = @quote.line_item_dates.includes(:line_items).ordered
  end

  def new
    @quote = Quote.new
  end

  def edit; end

  def create
    @quote = current_company.quotes.new(quote_params)

    if @quote.save
      respond_to do |f|
        f.turbo_stream { flash.now[:notice] = t('.successful') }
        f.html { redirect_to(quotes_path, notice: t('.successful')) }
      end
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def update
    if @quote.update(quote_params)
      respond_to do |f|
        f.turbo_stream { flash.now[:notice] = t('.successful') }
        f.html { redirect_to(quotes_path, notice: t('.successful')) }
      end
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @quote.destroy

    respond_to do |f|
      f.turbo_stream { flash.now[:notice] = t('.successful') }
      f.html { redirect_to(quotes_path, notice: t('.successful')) }
    end
  end

  private

  def set_quote
    @quote = current_company.quotes.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
