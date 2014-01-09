class QuizApp < Sinatra::Base

  namespace '/admins' do

    before { redirect to 'sessions/new' if authenticate == false }

    get '' do
      @current_admin = Admin.get(session[:admin_id])
      @admins = Admin.all
      haml :"admins/index"
    end

    get '/new' do
        @admin = Admin.new
        haml :"admins/new"
    end

    post '/new' do
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

    get '/:id/edit' do
      if (current_admin.super_admin? || (current_admin.id == params[:id].to_i))
        @admin = Admin.get(params[:id])
        haml :"admins/edit"
      else
        redirect to '/sessions/new'
      end
    end

    put '/:id/edit' do
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

    delete '' do
      admin = Admin.get(params[:admin_id])
      admin.destroy
      redirect to '/admins'
    end
  
  end
  
  get '/reset-session' do
    session[:admin_id] = nil
  end
end