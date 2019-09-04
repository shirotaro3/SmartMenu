class PagesController < ApplicationController
    def top
    end
    
    def about
        flash.now[:notice] = 'hello'
    end
end
