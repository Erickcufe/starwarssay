# starwarssay
A package with ASCII art of Star Wars

## Installation

```
if (!require(devtools)) {
    install.packages("devtools")
}
devtools::install_github("Erickcufe/seekerBio")
```

## Examples

```
starwarssay::say("I'm Your Father", by = "darth_vader", what_color = "darkred", by_color = "black")
starwarssay::say()
