' I'm avoiding "as string" as it causes a run time error if mismatch.

' @description Info level log. String expected for all params.
sub logInfo(componentName, functionName, message)
    if type(componentName) = "string" and type(functionName) = "string" and type(message) = "string"
        printLog("INFO", componentName, functionName, message)
    else
        ' ? "WARNING log params must be of type string"
    end if
end sub

' @description Debug level log. String expected for all params.
sub logDebug(componentName, functionName, message)
    sec = CreateObject("roRegistrySection", "RokuDisney")
    if sec.Exists("DebugEnabled") and sec.Read("DebugEnabled") = "true"
        if type(componentName) = "string" and type(functionName) = "string" and type(message) = "string"
            printLog("DEBUG", componentName, functionName, message)
        else
            ? "WARNING log params must be of type string"
        end if
    end if
end sub

' @description Warning level log. String expected for all params.
sub logWarning(componentName, functionName, message)
    if type(componentName) = "string" and type(functionName) = "string" and type(message) = "string"
        printLog("WARNING", componentName, functionName, message)
    else
        ? "WARNING log params must be of type string"
    end if
end sub

' @description Error level log. String expected for all params.
sub logError(componentName, functionName, message)
    if type(componentName) = "string" and type(functionName) = "string" and type(message) = "string"
        printLog("ERROR", componentName, functionName, message)
    else
        ? "WARNING log params must be of type string"
    end if
end sub

sub printLog(level as string, componentName as string, functionName as string, message as string)
    timestamp = CreateObject("roDateTime").ToISOString()
    ? level + " [" + timestamp + "] " + componentName + "." + functionName + ": " + message
end sub