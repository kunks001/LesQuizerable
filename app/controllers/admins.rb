class QuizApp < Sinatra::Base

  get '/admins' do
    if session[:admin_id]
      @admins = Admin.all
      haml :"admins/index"
    else
      redirect to '/sessions/new'
    end
  end

  get '/admins/new' do
    if session[:admin_id]
      @admin = Admin.new
      haml :"admins/new"
    else
      redirect to '/sessions/new'
    end
  end

  post '/admins/new' do
    if current_admin.super_admin?
      @admin = Admin.new(:email => params[:email], 
                :password => params[:password],
                :password_confirmation => params[:password_confirmation]
                )
      if @admin.save
        redirect to('/')
      else  
        flash.now[:errors] = @admin.errors.full_messages
        haml :"admins/new"
      end
    else 
      redirect to '/quizzes'
    end
  end

  get '/admins/:id/edit' do
    if session[:admin_id]
      @admin = Admin.get(params[:id])
      haml :"admins/edit"
    else
      redirect to '/sessions/new'
    end
  end

  put '/admins/:id/edit' do
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password_confirmation]

    admin = Admin.authenticate(current_admin.email, params[:current_password])

    if admin
      user = Admin.get!(params[:id])
      update_admin(user,email,password,password_confirmation)

      if user.save
        flash[:notice] = 'Your details have been successfully updated'
        redirect to('/')
      else
        flash.now[:errors] = ['Sorry, update failed. Please try again.']
        @admin = user
        haml :"admins/edit"
      end
    else
      @admin = Admin.get(params[:id])
      flash.now[:errors] = ['Incorrect authentication, please try again']
      haml :"admins/edit"
    end
  end

  get '/reset-session' do
    session[:admin_id] = nil
  end
  
end