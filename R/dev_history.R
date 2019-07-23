file.copy("../mortgage_forecasts/LICENSE", ".")
package_name <- "pyks"
library(tidyverse)

# once --------------------------------------------------------------------

file.copy("../mortgage_forecasts/setup.py", ".")
file.copy("../mortgage_forecasts/version.py", ".")
file.copy("../mortgage_forecasts/meta.yaml", ".")
dir.create("pyks")
file.copy("../mortgage_forecasts/mortgage_forecasts/__init__.py", "pyks/", overwrite = TRUE)
file.copy("../mortgage_forecasts/mortgage_forecasts/models.py", "pyks/ks.py", overwrite = TRUE)
file.edit("pyks/__init__.py")

use_readme_rmd()
file.copy("../mortgage_forecasts/README.Rmd", "README.Rmd", overwrite = TRUE)

read_file("README.Rmd") %>% str_replace_all("mortgage_forecasts", package_name) %>% write_file("README.Rmd")


# func writing ------------------------------------------------------------

file.edit("pyks/ks.py")


# ks v2 -------------------------------------------------------------------

file.copy("pyks/ks.py", "pyks/ks2.py")


# Add DESC ----------------------------------------------------------------

library(glue)

desc_text <- read_lines("setup.py") %>%
    str_subset("description") %>%
    str_match("'([[A-z]\\s]+)'") %>%
    .[1,2]
desc_file <- read_lines("DESCRIPTION")
desc_file[desc_file %>% str_which("Title")] <- glue("Title: {desc_text}")
desc_file[desc_file %>% str_which("Description")] <- glue("Title: {desc_text}")
desc_file %>%
    write_lines("DESCRIPTION")

add2pkg::add_me()

options(usethis.full_name = "Jiaxiang Li")
use_mit_license()

# 所以还是要用 R Package 的框架

use_news_md()
