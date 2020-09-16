usethis::create_package("~/package", rstudio = TRUE, roxygen = TRUE, open = FALSE,
                        fields = list(
                          Package = "package",
                          `Authors@R` = 'person("David", "Gohel", email = "david.gohel@ardata.fr", role = c("aut", "cre"))',
                          License = "GPL-3",
                          Title = "Dummy package",
                          Description = "Une boite a outil pour capitaliser les fonctions pratiques au quotidien.",
                          Version = "1.0.0"
                        ))
devtools::install("~/package")
