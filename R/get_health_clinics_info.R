#'  Get data about health clinics in the city of Rio de Janeiro, Brazil
#'
#'
#' @param name Name of the transportation service
#' @export
#' @examples
#' data <- get_health_clinics_info(name = "health")
#'
get_health_clinics_info <- function(name = c("health")) {
    name <- match.arg(name)
    url <- "http://dadosabertos.rio.rj.gov.br/"
    api_path <- "apiSaude/apresentacao/rest/index.cfm/estabelecimentos"
    req <- httr::GET(paste0(url, api_path))
    #reslist <- jsonlite::fromJSON(rawToChar(req$content))
    reslist <- jsonlite::fromJSON(rawToChar(req$content))
    df <- data.frame(reslist$DATA)
    names(df) <- reslist$COLUMNS
    df <- do.call(data.frame, df)
}



