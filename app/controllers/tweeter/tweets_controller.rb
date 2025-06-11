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
          @tweets = @publisher.tweets.lead_tweet.latest.where(status: @selected)
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
      if @tweet.thread 
        @tweet.sequence = @tweet.thread.get_next_sequence_number
      end
      # puts @tweet
      if @tweet.save
        if @tweet.sequence > 1 # subsequent tweets belonging to  a thread
          render 'create'
        else
          redirect_to tweet_path @tweet, notice: "Tweet was successfully created."
        end
      # else
      #   #todo: Give an error response if could not create
      #   render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tweets/1
    def update
      if @tweet.update(tweet_params)
        if params[:commit] == "Save"
          # redirect_to edit_tweet_path(@tweet), notice: "Saved at #{@tweet.updated_at}"
          # redirect_to tweet_path(@tweet)
          render "update"
        elsif params[:commit] == "Publish now"
          if @tweet.publish_now
            redirect_to tweet_path(@tweet)
          end
        elsif params[:commit] == "Publish later"
          if @tweet.publish_later
            redirect_to tweet_path(@tweet), notice: "Tweet scheduled for #{@tweet.published_at}"
          else
            render :edit, status: :unprocessable_entity
          end
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
      @tweet.thread.destroy!
      redirect_to publisher_tweets_path(@publisher, status: "draft"), notice: "Thread was successfully deleted.", status: :see_other
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tweet
        @tweet = Tweet.find(params.expect(:id))
        @publisher = @tweet.publisher
      end

      # Only allow a list of trusted parameters through.
      def tweet_params
        params.expect(tweet: [ :content, :publisher_id, :published_at, :thread_id, :image ])
      end
  end
end
