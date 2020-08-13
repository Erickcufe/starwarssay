get_who <- function(by) {

  by <- match.arg(by, choices = names(movie_characters))

  if (by == "random") {
    by <- sample(names(movie_characters), 1)
  }

  who <- movie_characters[by]

  who
}
