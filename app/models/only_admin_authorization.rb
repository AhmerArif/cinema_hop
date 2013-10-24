 # app/models/only_authors_authorization.rb
  class OnlyAdminAuthorization < ActiveAdmin::AuthorizationAdapter

      def authorized?(action, subject = nil)
        case subject
        when normalized(City)
            user.admin?
        when normalized(AdminUser)
            user.admin?
        when normalized(Cinema)
          if action == :update || action == :destroy || action == :create
            user.admin?
          else
            true
          end
        else
          true
        end
      end

  end