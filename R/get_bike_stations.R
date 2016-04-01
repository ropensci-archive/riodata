#'  Get bike station data from the city of Rio de Janeiro, Brazil
#'
#'
#' @param name Name of the transportation service
#' @export
#' @examples
#' data <- get_bike_stations(name = "bike")
#'
get_bike_stations <- function(name = c("bike")) {
    name <- match.arg(name)
    url <- "http://dadosabertos.rio.rj.gov.br/"
    api_path <- "apiTransporte/apresentacao/rest/index.cfm/estacoesBikeRio"
    req <- httr::GET(paste0(url, api_path))
    #reslist <- jsonlite::fromJSON(rawToChar(req$content))
    reslist <- jsonlite::fromJSON(rawToChar(req$content))
    df <- data.frame(reslist$DATA)
    names(df) <- reslist$COLUMNS
    df <- do.call(data.frame, df)
}








