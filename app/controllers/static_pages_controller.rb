class StaticPagesController < ApplicationController
  require 'meetup_client'

  MeetupApi.api_key   = ENV["MEETUP_KEY"]


end
