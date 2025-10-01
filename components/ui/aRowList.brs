sub init()
    m.componentName = m.top.subType()
    m.top.itemComponentName = "RowListItem"
    ' ToDo: Move this hardcoded initial data to the xml
    m.top.numRows = 2
    m.top.itemSize = [196 * 3 + 20 * 2, 213]
    m.top.rowHeights = [213]
    m.top.rowItemSize = [[196, 213], [196, 213], [196, 213]]
    m.top.itemSpacing = [0, 80]
    m.top.rowItemSpacing = [[20, 0]]
    m.top.rowLabelOffset = [[0, 30]]
    m.top.rowFocusAnimationStyle = "floatingFocus"
    m.top.showRowLabel = [true, true]
    m.top.rowLabelColor = "0xa0b033ff"
    m.top.content = GetRowListContent()
    m.top.visible = true
    m.top.SetFocus(true)
    m.top.ObserveField("rowItemFocused", "onRowItemFocused")

    logInfo(m.componentName, "init", "RowList Initialized")
end sub

function getRowListContent() as object
    data = CreateObject("roSGNode", "ContentNode")
    for numRows = 0 to 1
        row = data.CreateChild("ContentNode")
        row.title = "Row " + stri(numRows)
        for i = 1 to 3
            item = row.CreateChild("RowListItem")
            item.posterUrl = "http://devtools.web.roku.com/samples/images/Landscape_1.jpg"
            item.labelText = "Item " + stri(numRows * 3 + i)
        end for
    end for
    return data
end function

sub onRowItemFocused()
    row = m.top.rowItemFocused[0]
    col = m.top.rowItemFocused[1]
end sub