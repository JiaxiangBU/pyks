library(fs)
library(tidyverse)
dir_tree("../nbdev_template")
df <-
    dir_info("../nbdev_template") %>%
    select(path, type)
df %>%
    filter(type == 'file') %>%
    mutate(copy = map(path, file_copy, new_path = ".", overwrite = TRUE))
df %>%
    filter(type == 'directory') %>%
    mutate(copy = map(path, dir_copy, new_path = ".", overwrite = TRUE))
file_copy("../test_nbdev/settings.ini", ".", overwrite = TRUE)

library(devtools)
use_git_ignore(".Rproj.user")
use_git_ignore(".Rhistory")
use_git_ignore(".RData")


