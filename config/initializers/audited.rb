require "audited"

Audited.current_user_method = :current_admin
Audited::Railtie.initializers.each(&:run)