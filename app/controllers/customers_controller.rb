class CustomersController < ApplicationController
  before_action :logged_in_customer, only: [:index, :edit, :update, :destroy,
                                            :following, :followers]
  before_action :correct_customer,   only: [:edit, :update]
  before_action :admin_customer,     only: :destroy

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts
    @reviews = Review.where(customer_id: current_customer.id)
  end

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      @customer.send_activation_email
      flash[:notice] = "Please check your email to activate your account."
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to @customer
    else
      render 'edit'
    end
  end

  def destroy
    Customer.find(params[:id]).destroy
    flash[:success] = "Customer deleted"
    redirect_to customers_path
  end

  def following
    @title = "Читаю"
    @customer  = Customer.find(params[:id])
    @customers = @customer.following
    render 'show_follow'
  end

  def followers
    @title = "Меня читают"
    @customer  = Customer.find(params[:id])
    @customers = @customer.followers
    render 'show_follow'
  end

  private

    def customer_params
      params.require(:customer).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def logged_in_customer
      unless logged_in?
        store_location
        flash[:danger] = "Войдите или зарегистрируйтесь."
        redirect_to login_url
      end
    end

    def correct_customer
      @customer = Customer.find(params[:id])
      redirect_to(root_url) unless current_customer?(@customer)
    end

    def admin_customer
      redirect_to(root_url) unless current_customer.admin?
    end
end
