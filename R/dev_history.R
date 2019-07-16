file.copy("../mortgage_forecasts/LICENSE", ".")
package_name <- "pyKS"

# once --------------------------------------------------------------------

file.copy("../mortgage_forecasts/setup.py", ".")
file.copy("../mortgage_forecasts/version.py", ".")
file.copy("../mortgage_forecasts/meta.yaml", ".")
dir.create("pyKS")
file.copy("../mortgage_forecasts/mortgage_forecasts/__init__.py", "pyKS/", overwrite = TRUE)
file.copy("../mortgage_forecasts/mortgage_forecasts/models.py", "pyKS/ks.py", overwrite = TRUE)
file.edit("pyKS/__init__.py")

use_readme_rmd()
file.copy("../mortgage_forecasts/README.Rmd", "README.Rmd", overwrite = TRUE)

library(tidyverse)
read_file("README.Rmd") %>% str_replace_all("mortgage_forecasts", package_name) %>% write_file("README.Rmd")


# func writing ------------------------------------------------------------

file.edit("pyKS/ks.py")

