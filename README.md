# starwarssay
A package with ASCII art of Star Wars  

## Source 
https://www.asciiart.eu/movies/star-wars 
http://www.ascii-art.de/ascii/s/starwars.txt

## Installation

```
if (!require(devtools)) {
    install.packages("devtools")
}
devtools::install_github("Erickcufe/starwarssay")
```

## Examples

```
starwarssay::say("I'm Your Father", by = "darth_vader", what_color = "darkred", by_color = "black")
starwarssay::say()
