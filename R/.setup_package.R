pkg <- list(
  name = "minimarathon",
  title = "R Package for Visualising Results from BMW Minimarathon",
  desc = paste(
    "R Package for Visualising Results from BMW Minimaratho."
  )
)

kwb.pkgbuild::use_pkg_skeleton("minimarathon")

kwb.pkgbuild::use_pkg(
  pkg = pkg,
  copyright_holder = list(name = "Michael Rustler", start_year = NULL),
  user = "mrustl"
)

kwb.pkgbuild::use_ghactions()

kwb.pkgbuild::create_empty_branch_ghpages("minimarathon", org = "mrustl")

usethis::use_pipe()
usethis::use_vignette("Results_2022")
desc::desc_normalize()
