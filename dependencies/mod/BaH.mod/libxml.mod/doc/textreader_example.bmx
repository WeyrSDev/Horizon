Import BaH.Libxml

streamFile("tst.xml")

Function processNode(reader:TxmlTextReader)
	Print reader.depth() + " " + reader.nodeType() + " " + ..
		reader.name() + " " + reader.isEmptyElement() + " " + ..
		reader.value() 
		
	If reader.nodeType() = 1 Then ' Element
		While reader.moveToNextAttribute()
			Print "-- " + reader.depth() + " " + reader.nodeType() + " (" + ..
				reader.name() + ") ["+ reader.value() + "]"
		Wend
	End If
End Function

Function streamFile:Int(filename:String)
    Local reader:TxmlTextReader
    Local ret:Int

    reader = TxmlTextReader.fromFile(filename)
    If reader <> Null Then
        ret = reader.read()
        While ret = 1
            processNode(reader)
            ret = reader.read()
        Wend
        reader.free()
        If ret <> 0 Then
            Print filename + " : failed to parse"
        End If
    Else
        Print "Unable to open " + filename
    End If
End Function

Function parseAndValidate(filename)
	Local reader:TxmlTextReader = TxmlTextReader.fromFile(filename)
	
	reader.setParserProp(PARSER_VALIDATE, 1)
	
	ret = reader.read()
	While ret = 1
		ret = reader.read()
	wend
	If ret <> 0 Then
		Print "Error parsing and validating " + filename
	End If
End Function
