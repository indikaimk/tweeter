module Tweeter
  class TweetsController < ::ApplicationController
    layout "tweeter"
    before_action :set_tweet, only: %i[ show edit update publish destroy ]

    # GET /tweets
    def index
      @publisher = Tweeter.publisher_class.find(params[:publisher_id])
      # @tweets = @publisher.tweets

      if params[:status]
        @selected = params[:status]
        if @selected == "scheduled"
          @tweets = @publisher.tweets.by_publised_at.where(status: @selected)
        else
          @tweets = @publisher.tweets.latest.where(status: @selected)
        end
      else
        @tweets = @publisher.tweets.latest
      end
    end

    # GET /tweets/1
    def show
    end

    # GET /tweets/new
    def new
      @tweet = Tweet.new

    end

    # GET /tweets/1/edit
    def edit
    end

    # POST /tweets
    def create
      @tweet = Tweet.new(tweet_params)
      @publisher = @tweet.publisher
      puts @tweet
      if @tweet.save
        if @tweet.sequence > 1 # subsequent tweets belonging to  a thread
          render 'create'
        else
          redirect_to edit_tweet_path @tweet, notice: "Tweet was successfully created."
        end
      # else
      #   #todo: Give an error response if could not create
      #   render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tweets/1
    def update
      # if @tweet.update(tweet_params)
      #   redirect_to @tweet, notice: "Tweet was successfully updated.", status: :see_other
      # else
      #   render :edit, status: :unprocessable_entity
      # end
      if @tweet.update(tweet_params)
        if params[:commit] == "Save"
          # redirect_to edit_tweet_path(@tweet), notice: "Saved at #{@tweet.updated_at}"
          render 'show'
        elsif params[:commit] == "Post to Twitter"
          redirect_to publish_tweet_path
        elsif params[:commit] == "Schedule" && @tweet.schedule_tweet
          redirect_to tweet_path(@tweet), notice: "The tweet scheduled at #{@tweet.published_at}"
        elsif params[:commit] == "Post now" && @tweet.post_now
          redirect_to tweet_path(@tweet), notice: "CloudQubes is posting the tweet in the background"
        elsif params[:commit] == "Unpublish"
          redirect_to edit_tweet_path(@tweet)     
        else # Cancel
          redirect_to publisher_tweets_path(@tweet.publisher, status: "draft")
        end
      else
        render :edit, status: :unprocessable_entity
      end
  
    end

    def publish 
      
    end

    # DELETE /tweets/1
    def destroy
      @publisher = @tweet.publisher
      @tweet.destroy!
      redirect_to publisher_tweets_path(@publisher), notice: "Tweet was successfully destroyed.", status: :see_other
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tweet
        @tweet = Tweet.find(params.expect(:id))
        @publisher = @tweet.publisher
      end

      # Only allow a list of trusted parameters through.
      def tweet_params
        params.expect(tweet: [ :content, :publisher_id, :published_at, :thread_id ])
      end
  end
end
