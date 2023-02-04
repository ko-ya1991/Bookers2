class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @book = Book.new
    @books = Book.all
    @users = User.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if@book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @book2 = Book.new
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book2 = Book.new
    @book = Book.find(params[:id])
    @user = current_user
  end

  def edit
    # @user = User.find(params[:id])
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to '/books'
  end


  private

  def  book_params
    params.require(:book).permit(:title, :body, :image)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end


end
