class HomeController < ApplicationController
  def index #refers to views>home>index page
  end

  def about #refers to views>home>about page
  	@about_me = "My name is kiakou..."
  	@answer = 2+2
  end
end
