class BookmarksController < ApplicationController
  def create
    mystery = Mystery.find(params[:mystery_id])
    current_user.bookmark(mystery)
    redirect_to mysteries_path
  end

  def destroy
    mystery = current_user.bookmarks.find_by(mystery_id: params[:id]).mystery
    current_user.unbookmark(mystery)
    redirect_to mysteries_path
  end
end
