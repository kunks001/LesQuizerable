class QuizApp < Sinatra::Base

  get '/admins' do
    if session[:admin_id]
      @admins = Admin.all
      haml :"admins/index"
    else
      redirect to '/sessions/new'
    end
  end

  get '/admins/create-admin' do
    if session[:admin_id]
      @admin = Admin.new
      haml :"admins/create"
    else
      redirect to '/sessions/new'
    end
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
      haml :"admins/create"
    end
  end

  get '/admins/:id' do
    if session[:admin_id]
      @admin = Admin.get(params[:id])
      haml :"admins/edit"
    else
      redirect to '/sessions/new'
    end
  end

  put '/admins/:id' do
    @admin = Admin.get!(params[:id])
    @admin.update(:email => params[:email])
    if @admin.save
      flash[:notice] = 'Your details have been successfully updated'
      redirect to('/')
    else
      flash[:error] = 'Sorry, update failed. Please try again.'
      haml :"admins/edit"
    end
  end
  
end