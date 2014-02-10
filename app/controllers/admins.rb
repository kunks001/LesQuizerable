class QuizApp < Sinatra::Base

  namespace '/admins' do

    before { redirect to 'sessions/new' if current_admin == nil }

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
      redirect to '/quizzes' unless current_admin.super_admin?
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
    end

    get '/:id/edit' do
      redirect to '/sessions/new' unless editable_by_admin_with(params[:id])
      @admin = Admin.get(params[:id])
      haml :"admins/edit"
    end

    post '/:id/edit' do
      @admin = Admin.first(:id => params[:id])

      if @admin.update(:password => params['password'],
                        :password_confirmation => params['password_confirmation'])

        flash[:notice] = 'Your details have been successfully updated'
        redirect to("/admins/#{params[:id]}/edit")
      else
        flash[:error] = 'Sorry, update failed. Please try again.'
        redirect to("/admins/#{params[:id]}/edit")
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