if(FALSE) {
 men <- get_results("M")
 women <- get_results("W")
}


#' Get Teamstaffel Results Table
#'
#' @param sex either "M" for men or "W" for women default: "W"
#' @param year default: 2022
#' @param base_url default: "https://berlin.r.mikatiming.com"
#'
#' @return tibble with results
#' @export
#'
#' @examples
#' women <- get_results("W")
#' women
#' @importFrom dplyr arrange bind_rows mutate relocate
#' @importFrom  lubridate hms
get_results <- function(sex = "W",
                        year = 2022,
                        base_url = "https://berlin.r.mikatiming.com") {

event_id <- "G_2EF90BN8F3"


url <- sprintf("%s/%s/?page=%d&event=%s&num_results=100&pid=list&search[sex]=%s",
                 base_url,
                 year,
                 1,
                 event_id,
                 sex)


number_of_pages <- get_number_of_pages(url)
stopifnot(number_of_pages > 0)


res_list <- lapply(seq_len(number_of_pages), function(page) {

  url <- sprintf("%s/%s/?page=%d&event=%s&num_results=100&pid=list&search[sex]=%s",
                 base_url,
                 year,
                 page,
                 event_id,
                 sex)

get_result(url)

})

dplyr::bind_rows(res_list)   %>%
  dplyr::arrange(.data$finish_time) %>%
  dplyr::mutate(place = 1:dplyr::n()) %>%
  dplyr::relocate(.data$place)
}

#' Get Result
#'
#' @param url url
#'
#' @return reults for one page (i.e. at maximum 100)
#' @keywords internal
#' @noMd
#' @noRd
#'
#' @importFrom httr status_code POST
#' @importFrom xml2 read_html
#' @importFrom rvest html_nodes html_text
#' @importFrom tibble tibble
#' @importFrom stringr str_remove_all
#' @importFrom rlang .data
get_result <- function(url) {

resp <- httr::POST(url)
url_exists <- identical(httr::status_code(resp), 200L)

  if(!url_exists)
    stop(sprintf("url '%s' not existing!", url))


tmp <- url %>%
  xml2::read_html() %>%
  rvest::html_nodes(".col-sm-12") %>%
  rvest::html_nodes(".list-group-item")
tmp <- tmp[-1]



type_fields <- tmp %>%
  rvest::html_nodes(".type-field")

n <- length(type_fields)

start_number <- type_fields[seq(1, n, 3)]
age_class <- type_fields[seq(2, n, 3)]
school <- type_fields[seq(3, n, 3)]


tibble::tibble(
               fullname = tmp %>%
                 rvest::html_nodes(".type-fullname") %>%
                 rvest::html_text(),
               start_number = start_number %>%
                 rvest::html_text() %>%
                 stringr::str_remove("Number") %>%
                 as.integer(),
               age_class = age_class %>%
                 rvest::html_text() %>%
                 stringr::str_remove_all("^AC"),
               school = school %>%
                 rvest::html_text() %>%
                 stringr::str_remove_all("^Schule"),
               finish_time = tmp %>%
                 rvest::html_nodes(".type-time") %>%
                 rvest::html_text() %>%
                 stringr::str_remove_all("^Time")) %>%
  dplyr::mutate(finish_time = dplyr::if_else(nchar(.data$finish_time) == 1,
                                             NA_character_,
                                             .data$finish_time)) %>%
  dplyr::mutate(finish_time = lubridate::hms(.data$finish_time))

}

#' Get Number of Pages
#'
#' @param url url
#'
#' @return number of pages
#' @keywords internal
#' @noMd
#' @noRd
#' @importFrom stringr str_extract
get_number_of_pages <- function(url) {
  url %>%
    xml2::read_html(url) %>%
    rvest::html_element(css = ".pagination") %>%
    rvest::html_elements(css = "a") %>%
    rvest::html_text() %>%
    stringr::str_remove_all(pattern = "...|>") %>%
    as.integer() %>%
    max(na.rm = TRUE)
}
