' I'm avoiding "as string" as it causes a run time error if mismatch.
' I reget trying to add a simple logger. I just learned about string
' becomeing roString after it's used in an expression. -CyM

' @description Info level log. String expected for all params.
' @param componentName as string used here for resolve issues with m.compnentName becoming aa roString
sub logInfo(componentName as string, functionName, message)
    if type(functionName) = "String" and type(message) = "String"
        printLog("INFO", componentName, functionName, message)
    else
        ? "INFO log params must be of type string"
    end if
end sub

' @description Debug level log. String expected for all params.
' @param componentName as string used here for resolve issues with m.compnentName becoming aa roString
sub logDebug(componentName, functionName, message)
    sec = CreateObject("roRegistrySection", "RokuDisney")
    if sec.Exists("DebugEnabled") and sec.Read("DebugEnabled") = "true"
        if type(functionName) = "String" and type(message) = "String"
            printLog("DEBUG", componentName, functionName, message)
        else
            ? "DEBUG log params must be of type string"
        end if
    end if
end sub

' @description Warning level log. String expected for all params.
' @param componentName as string used here for resolve issues with m.compnentName becoming aa roString
sub logWarning(componentName as string, functionName, message)
    if type(functionName) = "String" and type(message) = "String"
        printLog("WARNING", componentName, functionName, message)
    else
        ? "WARNING log params must be of type string"
    end if
end sub

' @description Error level log. String expected for all params.
' @param componentName as string used here for resolve issues with m.compnentName becoming aa roString
sub logError(componentName as string, functionName, message)
    if type(functionName) = "String" and type(message) = "String"
        printLog("ERROR", componentName, functionName, message)
    else
        ? "ERROR log params must be of type string"
    end if
end sub

' @description Treat this as a private function. Only to be called from the above logLevel functions
sub printLog(level as string, componentName as string, functionName as string, message as string)
    timestamp = CreateObject("roDateTime").ToISOString()
    ? level + " [" + timestamp + "] " + componentName + "." + functionName + ": " + message
end sub