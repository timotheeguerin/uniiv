class WelcomeController < ApplicationController
  def index
    if current_user.role? :alpha_tester
      puts 'ALPGA'
    else
      puts 'NOPE'
    end

  end
end
