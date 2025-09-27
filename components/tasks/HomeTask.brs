sub init()
    m.top.functionName = "fetchHomeContent"
end sub

sub fetchHomeContent()
    ' tracking request time for debugging ToDo: Remove or comment out for release
    tiemSpan = createObject("roTimeSpan")
    homeContent = createObject("roSGNode", "ContentNode")
    request = createObject("roUrlTransfer")
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    ' not really needed, given the scope of this
    request.addHeader("X-Roku-Reserved-Dev-Id", "")
    request.initClientCertificates()
    request.setUrl("https://cd-static.bamgrid.com/dp-117731241344/home.json")
    ' FixMe: add error checking to this.
    response = request.getToString()
    ' Type for categories
    ' data.StandardCollection.containers.set.type = "CurratedSet"
    ' Sections tiles
    ' data.StandardCollection.containers.set.text.title.full.setdefault.content
    ' Icons to be shown in layout
    ' data.StandardCollection.containers.set.items.1.78...something,
    ' go back to postman and fine this out after the rows are set up.
    json = parseJson(response)
    createCurratedSets(json)

    ? "fetch took", tiemSpan.totalMilliseconds().toStr(), " milliseconds"
end sub

sub createCurratedSets(json as object)
    ' ToDo: name things better
    thingsIWant = json.data.StandardCollection.containers[0].set
    ? "thingsIWant: ", thingsIWant
    ' set up rows of stuff if CuratedSet
    if thingsIWant.type = "CuratedSet"
        ? "Woo! found my CuratedSet"
        ' FixMe: this may need to be an array of objects...later
        curratedSets = {
            type: thingsIWant
            title: thingsIWant.text.title.full.set.default.content
            ' icon is later, get the others working first.
            ' icon: thingsIWant.items[1.78].uri?
        }
        ? "curratedSets: ", curratedSets
        ' ToDo: add some fun to deal with CuratedSets
    else
        ? "what type are you? ", thingsIWant.type
    end if


    ' FixMe: I'll sort this later.
    if thingsIWant.type = "RefSet"
        ? "Found my RefSet, used for...something?"
        ' ToDo: add some fun to deal with RefSets
    else
        ? "what type are you? ", thingsIWant.type
    end if
end sub