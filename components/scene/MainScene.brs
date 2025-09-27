sub init()
    m.top.setFocus(true)
    ' junk to remove after I build the proer scene
    m.initLabel = m.top.findNode("initLabel")
    m.initLabel.font.size = 92

    fetchHomeData()
end sub

sub fetchHomeData()
    if m.progress = invalid then
        m.progress = createObject("roSGNode", "ProgressDialog")
        m.progress.title = "Loading...I assume"
        m.progress.message = "Did you know:" + chr(10) + "You can use the replay key to update the list!"
        m.top.dialog = m.progress
    end if

    if m.homeRequest <> invalid then
        m.homeRequest.unobserveField("homeContent")
    end if
    m.homeRequest = CreateObject("roSGNode", "HomeTask")
    m.homeRequest.control = "RUN"
    ' Todo: Clear progress bar after
end sub