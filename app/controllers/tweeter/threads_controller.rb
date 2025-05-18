module Tweeter
  class ThreadsController < ApplicationController

    def update 
      if params[:commit] == "Post to Twitter"
        redirect_to publish_tweet_path
      end
    end
  end
end
