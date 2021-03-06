class SessionsController < ApplicationController

  def new
    
  end

  def create
    user = User.where(username: params[:username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Felicidades, ahora puedes publicar, commentar, y votar!"
      redirect_to root_path
    else
      flash[:error] = "Existe un problema con tu nombre o contrasena."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Se ha cerrado tu sesion."
    redirect_to root_path
  end
end
