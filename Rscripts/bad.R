library(profvis)

extract_text_features_b <- function(file_address, keywords) {
  #' gets the keywords as input and returns the dataframe including those keywords along with the number of keywords
  #' 
  #' @param keyword: a list of keywords
  #' @return results: a dataframe including movies with the keyword and number of words in the summary
  
  # read in the plot summaries from txt file
  plot_summary <- read.table(file_address, sep = '\t', quote = '', stringsAsFactors = FALSE)
  plot_summary <- as.list(plot_summary)

  for (i in 1:length(plot_summary[[1]])) {
    text = plot_summary[[2]][i]
    # set the existence of either keyword in the text
    word_exists <- all(sapply(keywords, grepl, text))
    # count number of words in the text
    word_count <- sapply(strsplit(tolower(text), " "), length)
    # insert the keyword existence and word counts into associated columns
    plot_summary[['keyword']][i] <- word_exists
    plot_summary[['word_count']][i] <- word_count
  }
  # filter out and return the rows that has the keyword 
  result = plot_summary[plot_summary$keyword == 1][c('V1', 'keyword', 'word_counts')]
  results <- plot_summary[plot_summary$keyword == 1, c('V1', 'keyword', 'word_counts')]
  return(results)
}

profvis(tst <- extract_text_features(file_address = 'data/plot_summaries.txt', 
                                     keywords = c('love', 'world war')))
