Type TUtility

	Function UpdateValue#(current#,destination#,rate#)
	
		current#=current#+((destination#-current#)*rate#)
	
		Return current#
	
	End Function

End Type
