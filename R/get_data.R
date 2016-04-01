#'  Get the data from Rio de Janeiro
#'
#'
#' @param name Name of the transportation service
#' @export
#' @examples
#' data <- get_data(name = "supervia")
#'
get_data <- function(name = c("pontosculturais", "metro", "brt", "supervia")) {

    name <- match.arg(name)
    url <- "http://dadosabertos.rio.rj.gov.br/"
    api_path <- "/api/v1/rest/"
    names_data <- c("pontosculturais", "metro", "brt", "supervia")
    names_place <- c("PontosCulturais", "Estacoes", "EstacoesTranscarioca", "estacoes")
    tokens <- c("0DEF20BC-FCC3-316D-2B094AB44B2C4F76", "40A22Af7-A9C6-86D6-E211Aba64Bf73830",
                "7A32FDD1-CF97-4B1D-4BEE71037BAAEAF2", "414353CA-D860-271B-3972665CCA1C05EE")
    lookup <- data.frame(data = names_data, place = names_place, token = tokens,
                         stringsAsFactors = FALSE)
    place <- lookup[which(lookup$data == name),c("place")]
    token <- lookup[which(lookup$data == name),c("token")]
    req <- httr::GET(paste0(url, name, api_path, place, ".cfm?token=", token))
    reslist <- httr::content(req, "parsed")
    sreslist <- sapply(reslist, function(ll) ll[sort(names(ll))], simplify = FALSE)
    df <- do.call(rbind.data.frame, sreslist)
}



