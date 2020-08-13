
say <- function(what="May the force be with you", by="stormtrooper",
                what_color=NULL, by_color=NULL, ...) {

  if (crayon::has_color() == FALSE && (!is.null(what_color) || !is.null(by_color))) {
    message("Colors cannot be applied in this environment :( Try using a terminal or RStudio.")
    what_color <- NULL
    by_color <- NULL
  } else {
    what_color <- check_color(what_color)
    by_color <- check_color(by_color)
  }

  who <- get_who(by)


  what_pos_start <- regexpr('%s', who)[1] - 1

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


  out <- paste0(color_text(substr(who, 1, what_pos_start),
                           by_color),
                color_text(what,
                           what_color),
                color_text(substr(who, what_pos_end, nchar(who)),
                           by_color))

  message(out)

}
