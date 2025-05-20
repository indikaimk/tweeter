module Tweeter
  class ThreadsController < ::ApplicationController
    layout "tweeter"
    before_action :set_thread, only: %i[ update publish ]

    def update 
      if @thread.update(thread_params)
        if params[:commit] == "Post to Twitter"
          redirect_to publish_thread_path(@thread)
        elsif params[:commit] == "Schedule" && @thread.publish_later
          redirect_to tweet_path(@thread.tweet), notice: "The thread scheduled at #{@tweet.published_at}"
        elsif params[:commit] == "Post now" && @thread.publish_now
          redirect_to tweet_path(@tweet), notice: "CloudQubes is posting the tweet in the background"
        elsif params[:commit] == "Unpublish"
          redirect_to edit_tweet_path(@tweet)     
        else
          
        end
      end
    end

    def publish 
      
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_thread
        @thread = Thread.find(params.expect(:id))
        @publisher = @thread.publisher
      end

      def thread_params 
        params.expect(thread: [ :published_at ])
      end

  end
end
