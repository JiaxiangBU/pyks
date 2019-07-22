file.copy("../mortgage_forecasts/LICENSE", ".")
package_name <- "pyks"

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

library(tidyverse)
read_file("README.Rmd") %>% str_replace_all("mortgage_forecasts", package_name) %>% write_file("README.Rmd")


# func writing ------------------------------------------------------------

file.edit("pyks/ks.py")


# ks v2 -------------------------------------------------------------------

file.copy("pyks/ks.py", "pyks/ks2.py")
