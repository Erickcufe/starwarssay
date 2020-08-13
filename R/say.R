#' Messages with star wars characters
#'
#' @param what (character) What do you want to say?
#' @param by (character) Select a some character, baby_yoda, R2D2, black_one, at_at_walker,
#' darth_vader, resistance, at_st_walker, yoda, ackbar, darth_maul, stormtrooper and stormtrooper_body,
#' starwars, starwars_2, millenium_falcon.
#' Alternatively, use "random" to have your message spoken by a random character.
#' @param what_color (character or crayon function) One or more
#' \href{https://github.com/r-lib/crayon#256-colors}{\code{crayon}}-suported
#' text color(s) or
#' \href{https://github.com/r-lib/crayon#styles}{\code{crayon style function}}
#' to color `what`. You might try `colors()` or `?rgb` for ideas.
#' Use "rainbow" for c("red", "orange", "yellow", "green", "blue", "purple").
#' @param by_color (character or crayon function) One or more
#' \href{https://github.com/r-lib/crayon#256-colors}{\code{crayon}}-suported
#' text color(s) or
#' \href{https://github.com/r-lib/crayon#styles}{\code{crayon style function}}
#' to color `who`. Use "rainbow" for
#' `c("red", "orange", "yellow", "green", "blue", "purple")`
#'
#' @return
#' A message with your selected character
#'
#'
#' @examples
#' say()
#' say("I'm your father", by = "darth_vader", by_color = "black")
#'
#' @export
say <- function(what="May the force be with you", by="stormtrooper",
                what_color=NULL, by_color=NULL) {

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
