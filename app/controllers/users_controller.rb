class UsersController < ApplicationController
    
    def index
        # byebug
        users = User.all
        render json: {users: users} , :include => [:conversations]
    end

    def show
        user = User.find(params[:id])
        # render json: {user: user}
        # render json: {user: user} , :include => [:posts]
        # render json: {user: user} , :include => [:comments]
        render json: {user: user} , :include => [:conversations, :posts, :comments]
        # render json: {user: user} , :include => [:messages]
        # render json: {user: user} , :include => [:follows]
    end

    def edit
        user = User.find(params[:id])
    end 

    def update
        user = User.find(params[:id])
        if user.update(user_params)
            render json: user
        else
            render json: {error: "Something went wrong"}
        end
    end

    def destroy
        user = User.find(params[:id])
        if user.destroy
            render json: {message: "Successfully deleted user"}
        else
            render json: {error: "Something went wrong"}
        end
    end

    private

    def user_params
        params.require(:user).permit(:user_name, :password, :first_name, :last_name, :age, :bio, :admin, :gender, :city, :country)
    end

end