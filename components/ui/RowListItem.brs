sub init()
    m.componentName = m.top.subType()
    m.itemImage = m.top.findNode("itemImage")
    m.itemText = m.top.findNode("itemText")
    logInfo(m.componentName, "init", "")
end sub

sub itemContentChanged()
    itemData = m.top.itemContent
    m.itemImage.uri = itemData.posterUrl
    m.itemText.text = itemData.labelText
end sub