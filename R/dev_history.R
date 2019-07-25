file.copy("../mortgage_forecasts/LICENSE", ".")
package_name <- "pyks"
library(tidyverse)
library(glue)

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



desc_text <- read_lines("setup.py") %>%
    str_subset("description") %>%
    str_match("'([[A-z]\\s]+)'") %>%
    .[1,2]
desc_file <- read_lines("DESCRIPTION")
desc_file[desc_file %>% str_which("Title")] <- glue("Title: {desc_text}")
desc_file[desc_file %>% str_which("Description")] <- glue("Description: {desc_text}")
desc_file %>%
    write_lines("DESCRIPTION")

add2pkg::add_me()

options(usethis.full_name = "Jiaxiang Li")
use_mit_license()

# 所以还是要用 R Package 的框架

use_news_md()



# update version ----------------------------------------------------------

file.edit("NEWS.md")
library(devtools)
use_version()

version_text <- read_lines("DESCRIPTION") %>%
    str_subset("Version") %>%
    str_match("(\\d+\\.\\d+\\.\\d+)") %>%
    .[1,2]
init_file <- read_lines("pyks/__init__.py")
init_file[init_file %>% str_which("__version__")] <- glue("__version__ = '{version_text}'")
init_file %>% write_lines("pyks/__init__.py")


# build -------------------------------------------------------------------

# conda build . # conda
usethis::use_github_release() # Use MacOS

# /Users/vija/miniconda3/conda-bld/noarch/
# pyks-0.1.1-py_1.tar.bz2
# 版本不对
library(fs)
upload_file_path <-
dir_info("/Users/vija/miniconda3/conda-bld/noarch/")$path %>%
    str_subset("pyks") %>%
    max
# anaconda login

glue("anaconda upload {upload_file_path}") %>% clipr::write_clip() %>% cat

# pypi --------------------------------------------------------------------
# Python Package Index

# https://packaging.python.org/tutorials/packaging-projects/
file.edit("setup.py")
file.edit("pyks/__init__.py")
# python -m pip install --user --upgrade setuptools wheel
# Successfully installed wheel-0.33.4
# python setup.py sdist bdist_wheel

# $ ls dist
# pyks-0.1.1-py3-none-any.whl  pyks-0.1.1.tar.gz

# python -m pip install --user --upgrade twine
# python -m twine upload --repository-url https://test.pypi.org/legacy/ dist/* --verbose
# python -m twine upload dist/*
