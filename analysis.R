library("httr")
library("jsonlite")
library("twitteR")
library("dplyr")
source("apikeys.R")


setup_twitter_oauth(
  consumer_key = twitter_key,
  consumer_secret = twitter_secret,
  access_token = access_token,
  access_secret = access_secret
)

# Returns important information about up to 25 popular tweets in English about the given query.
get_tweets_by_query <- function(query) {
  search <- searchTwitter(query, lang = "en", resultType = "popular")
  search <- twListToDF(search)
  search <- select(search, text, truncated, favoriteCount, retweetCount, screenName, created)
}

# Returns up to 50 of the trending topics in the specified location.
get_trends_by_id <- function(woeid) {
  trends <- getTrends(woeid)
}

# Returns a string with the given country's woeid, or Where On Earth Identifier.
# Only works for countries which trends are available in.
get_woeid_of_country <- function(country_name) {
  all_locations <- availableTrendLocations()
  country_table <- filter(all_locations, name == country_name, country == country_name)
  country_woeid <- country_table$woeid
}

# Takes a WOEID and returns a dataframe of summary statistics for the most popular tweets
# related to the 25 most popular trends in the given location. Looks at only the number of
# favorites for each tweet.
get_summary_of_tweets <- function(woeid){
  trends_df <- get_trends_by_id(woeid) 
  trends_df <- trends_df[1, ]
  df_tweets <- get_tweets_by_query(trends_df$name)
  summary <- c(summary(df_tweets$favoriteCount))
  summary_tweets <- data.frame(t(summary)) %>% 
    select(-X1st.Qu., -X3rd.Qu.) %>% 
    mutate(Name = trends_df$name) 
  summary_tweets[, c(5, 1, 2, 3, 4)]
}

mode <- function(char){
  uniqchar <- unique(char)
  uniqchar[which.max(tabulate(match(char, uniqchar)))]
}

get_max_tweet_trends <- function(trend){
  df_tweets <- get_tweets_by_query(trend)
  max_active_account <- mode(c(df_tweets$screenName))
}
