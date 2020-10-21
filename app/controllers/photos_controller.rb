class PhotosController < ApplicationController
    skip_before_action :authorized, only: [:index, :create]

    def index
        photos = Photo.all 
        render json: photos
    end


    def create
        
        image = Cloudinary::Uploader.upload(params[:image])
        
        photo = Photo.create(img_url: image["url"], recipe_id: params["recipe_id"].to_i, description: params["description"])
        

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
        params.require(:photo).permit(:recipe_id, :img_url, :image)
    end

end
