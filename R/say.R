
say <- function(what="May the force be with you", by="stormtrooper",
                type=NULL,
                what_color=NULL, by_color=NULL, ...) {

  # if (length(what) > 1) {
  #   stop("what has to be of length 1", call. = FALSE)
  # }
  #
  if (crayon::has_color() == FALSE && (!is.null(what_color) || !is.null(by_color))) {
    message("Colors cannot be applied in this environment :( Try using a terminal or RStudio.")
    what_color <- NULL
    by_color <- NULL
  } else {
    what_color <- check_color(what_color)
    by_color <- check_color(by_color)
  }

  if (is.null(type)) {
    if (interactive()) {
      type <- "message"
    } else {
      type <- "print"
    }
  }

  # if (what == "catfact") {
  #   check4pkg("jsonlite")
  #   what <-
  #     jsonlite::fromJSON(
  #       'https://catfact.ninja/fact')$fact
  #   by <- 'cat'
  # }
  #
  who <- get_who(by, length = length)

  # if (!is.null(fortune)) what <- "fortune"
  #
  # if (what == "time")
  #   what <- as.character(Sys.time())
  # if (what == "fortune") {
  #   if ( is.null(fortune) ) fortune <- sample(1:360, 1)
  #   what <- fortune(which = fortune, ...)
  #   what <- what[!is.na(what)] # remove missing pieces (e.g. "context")
  #   what <- gsub("<x>", "\n", paste(as.character(what), collapse = "\n "))
  # }
  #
  # if (by == "hypnotoad" && what == "Hello world!") {
  #   what <- "All Glory to the HYPNO TOAD!"
  # }
  #
  # if (what == "rms") {
  #   what <- rmsfact::rmsfact()
  # }

  # if ( what %in% c("arresteddevelopment", "doctorwho", "dexter", "futurama",
  #                  "holygrail", "simpsons", "starwars", "loremipsum")
  # ) {
  #   stop("sorry, fillerama API is down", call.=FALSE)
  #   # check4pkg("jsonlite")
  #   # what <-
  #   #   jsonlite::fromJSON(
  #   #     paste0('http://api.chrisvalleskey.com/fillerama/get.php?count=1&format=json&show=', what))$db$quote
  # }

  what_pos_start <-
    regexpr('%s', who)[1] - 1

  what_pos_end <- what_pos_start + 3

  color_text <- function(txt, c) {
    if (is.null(c)) {
      out <- txt
    } else if (!is.null(c) && inherits(c, "crayon")) {
      out <- c(txt)
    } else if (!is.null(c) && is.character(c)) {
      if (length(c) <= 1) {
        c <- crayon::make_style(c)
        out <- c(txt)
      } else if (length(c) >= 1) {
        out <- multicolor::multi_color(txt, c,
                                       type = "string")
      }
    }
    return(out)
  }

  # TODO: when multicolor doesn't color every character individually, this should be possible
  # and we can get rid of what_pos_start and what_pos_end
  # what <- color_text(what, what_color)
  # who <- color_text(who, by_color)
  # out <- sprintf(who, what)

  # switch(type,
  #        message = message(sprintf(who, what)),
  #        warning = warning(sprintf(who, what)),
  #        string = sprintf(who, what))

  out <- paste0(color_text(substr(who, 1, what_pos_start),
                           by_color),
                color_text(what,
                           what_color),
                color_text(substr(who, what_pos_end, nchar(who)),
                           by_color))

  if (type == "warning") {
    if (nchar(out) < 100) {
      wl <- 100
    } else if (nchar(out) > 8170) {
      wl <- 8170
    } else {
      wl <- nchar(out) + 1
    }
    warn_op <- options(warning.length = wl)
    on.exit(options(warn_op))
  }

  switch(type,
         message = message(out),
         warning = warning(out),
         print = cat(out),
         string = out)
}
