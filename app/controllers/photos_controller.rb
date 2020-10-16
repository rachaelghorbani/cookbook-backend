class PhotosController < ApplicationController

    def create
        photo = Photo.new(photo_params)
        if photo.save 
            render json: photo
        else
            render json: {error: photo.errors.full_messages}, status: :not_acceptable
        end
    end

    def destroy
        photo = Photo.find(params[:id])
        photo.destroy
        render json: photo
    end

    private

    def photo_params
        params.require(:photo).permit(:recipe_id, :mg_url)
    end
end
end
