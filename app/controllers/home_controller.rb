class HomeController < ApplicationController
    prepend_before_action :verify_auth_user
    def index
    end
end
