class StudentsController < ApplicationController
  def index
  if(session[:current_user_id])
  @students = Student.find(session[:current_user_id])
  else
  	redirect_to '/login'
  end
  end
  
  def new
  	if(session[:current_user_id])
  		redirect_to '/students/'+ session[:current_user_id].to_s
  	else
  	@students = Student.new
  end
  end
  
  def create
  @students = Student.new(student_params)
  respond_to do |format|
      if @students.save
        format.html { redirect_to @students, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @students }
      else
        format.html { render :new }
        format.json { render json: @students.errors, status: :unprocessable_entity }
      end
  end
 
end
  
  def show
  	if(params[:t] == "512")
  	reset_session
  	end
  	if(session[:current_user_id])
  @students = Student.find(session[:current_user_id])
  else
  	redirect_to '/login'
  end
  end

  def edit
  	if(session[:current_user_id])
  @students = Student.find(session[:current_user_id])
  else
  	redirect_to '/login'
  end
  	
  end

  def update
  	@students = Student.find(session[:current_user_id])
    if @students.update_attributes(student_params)
  	redirect_to '/students/'+session[:current_user_id].to_s
  	end
  end

  

def destroy
  cookies.delete(:auth_token)
  redirect_to root_url, :notice => "Logged out!"
end



  def s_login
  	mail = params[:student][:email]
  	pass = params[:student][:password]
  	check1 = Student.where(email: mail)
  	check = check1.where(password: pass)
  	if(check[0])
  	session[:current_user_id] = check[0].id
  	if params[:remember_me]
      cookies.permanent[:auth_token] = check[0].auth_token
    else
      cookies[:auth_token] = check[0].auth_token
    end
    redirect_to '/students'
  	else
  		redirect_to '/login'
  	end
  end

  def login_student
  	if session[:current_user_id]
  		redirect_to '/students/' + session[:current_user_id].to_s
  	end
  end

  private
  def set_position
      @students = Student.find(params[:id])
    end
  def student_params
      params.require(:student).permit(:email, :password, :password_confirmation, :auth_token, :password_reset_token, :password_reset_sent_at)
    end
end
