' @description Treat this as private
' @return The base url used to assemble full URLs
function getBaseUrl() as string
    return "https://cd-static.bamgrid.com/dp-117731241344/"
end function

' @description Treat as CONST for home.json URL
' @return full URL for home.json
function getHomeUrl() as string
    return getBaseUrl() + "home.json"
end function

' @description Treat as CONST for sets/{refId}.json URL
' @param refId ID to of content to get from home.json
' @return full URL for {refId}.json
function getSetRefUrl(refId as string) as string
    return getBaseUrl() + "sets/" + refId + ".json"
end function