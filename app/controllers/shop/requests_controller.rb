class Shop::RequestsController < ApplicationController
    before_action :authenticate_shop!
end
