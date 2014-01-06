class QuizApp < Sinatra::Base

	get '/admins' do
    
  end

  get '/admins/create-admin' do
    @admin = Admin.new
    haml :"admins/create"
  end

  post '/admins/create-admin' do
    @admin = Admin.new(:email => params[:email], 
              :password => params[:password],
              :password_confirmation => params[:password_confirmation]
              )
    if @admin.save
      session[:admin_id] = @admin.id
      redirect to('/')
    else
      flash.now[:errors] = @admin.errors.full_messages
      # flash[:notice] = "Sorry, your passwords don't match"
      haml :"admins/create"
    end
  end

  get '/admins/edit' do
    if session[:admin_id]
      @admin = Admin.get(session[:admin_id])
      haml :"admins/edit"
    else
      redirect to '/sessions/new'
    end
  end

  post '/admins/edit' do
    @admin = Admin.get!(session[:admin_id])
    if params[:password] != ""
      @admin.update(:email => params[:email], 
                :password => params[:password],
                :password_confirmation => params[:password_confirmation]
                )
    else
      @admin.update(:email => params[:email])
    end
    if @admin.save
      flash[:notice] = 'Your details have been successfully updated'
      redirect to('/')
    else
      flash[:error] = 'Sorry, update failed. Please try again.'
      haml :"admins/edit"
    end
  end
  
end