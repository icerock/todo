# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  include AuthenticatedSystem

  #HARVESTER OF SORROW :)

  require "harvest.rb"

  def harv_connect
    @harvest = Harvest(:email      => "anthony.icerock@gmail.com",
                       :password   => "Ice6667",
                       :sub_domain => "bambu4a",
                       :headers    => {"User-Agent" => "todo app"})

  end

  

end
