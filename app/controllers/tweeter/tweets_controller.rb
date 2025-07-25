module Tweeter
  class TweetsController < ::ApplicationController
    layout "tweeter"
    before_action :set_tweet, only: %i[ show edit update publish destroy ]
    around_action :switch_time_zone, only: %i[ edit update publish index show ]


    # GET /tweets
    def index
      @publisher = Tweeter.publisher_class.find(params[:publisher_id])
      # @tweets = @publisher.tweets
      # @selected = params[:status] #To apply the CSS to the selected tab
      if params[:status]
        @selected = params[:status] #To apply the CSS to the selected tab
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
        @previous_tweet = Tweet.find_by(id: params.dig(:previous_tweet_id)) || @tweet.thread.tweets.by_thread_sequence.last
        @tweet.sequence = @tweet.thread.get_next_sequence_number(@previous_tweet)
        # @tweet.thread.update_sequence(@tweet, previous_tweet)
      end
      
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
      @tweet.destroy!
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
