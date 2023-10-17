ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation

  # Customize this block to restrict access to specific actions or fields
  controller do
    def update
      unless current_admin_user
        redirect_to root_path, notice: "You don't have permission to update users."
      else
        super
      end
    end
  end
end
