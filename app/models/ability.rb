class Ability
    include CanCan::Ability

    def initialize(user)
        roles = []

        if user.present?
            roles = user.roles
        else
            roles << Role.find_by_title('Unregistered User')
        end

        roles.each do |role|
            role.permissions.each do |permission|
                if permission.allowed === true
                    if permission.instance_id.nil?
                        can permission.action.to_sym, permission.model.constantize
                    else
                        can permission.action.to_sym, permission.model.constantize, :id => permission.instance_id
                    end
                else
                    if permission.instance_id.nil?
                        cannot permission.action.to_sym, permission.model.constantize
                    else
                        cannot permission.action.to_sym, permission.model.constantize, :id => permission.instance_id
                    end
                end
            end
        end
    end
end
