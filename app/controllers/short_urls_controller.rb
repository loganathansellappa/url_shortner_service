class ShortUrlsController < ApplicationController

  def generate
    @short_url =  ShortUrl.get_short_url(params[:url])
    if @short_url.try(:errors)
      render json: { errors: @short_url.errors.full_messages}, status: 400
    else
      render json: { url: short_url(@short_url)}
    end
  end

  def show

    @short_url =  ShortUrl.find_by(shorted_url: params[:url])
    if (@short_url.try(:shorted_url))
     

      redirect_to(@short_url.original_url)
    else
      render json: { errors: 'Url Not Found'}, status: 404
    end
  end
end




