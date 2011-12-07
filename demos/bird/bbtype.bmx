' BBType adds legacy Type functionality to BlitzMax Type

Type TBBType

	Field _list:TList
	Field _link:TLink

	Method Add(t:TList)
		_list=t
		_link=_list.AddLast(self)
	End Method

	Method InsertBefore(t:TBBType)
		_link.Remove
		_link=_list.InsertBeforeLink(self,t._link)
	End Method

	Method InsertAfter(t:TBBType)
		_link.Remove
		_link=_list.InsertAfterLink(self,t._link)
	End Method

	Method Remove()
		_list.remove self
	End Method

End Type

Function DeleteLast(t:TBBType)
	if t TBBType(t._list.Last()).Remove()
End Function

Function DeleteFirst(t:TBBType)
	if t TBBType(t._list.First()).Remove()
End Function

Function DeleteEach(t:TBBType)
	if t t._list.Clear()
End Function

Function ReadString$(in:TStream)
	local	length
	length=readint(in)
	if length>0 and length<1024*1024 return brl.stream.readstring(in,length)
End Function

Function HandleToObject:Object(obj:Object)
	Return obj
End Function

Function HandleFromObject(obj:Object)
	Local h=HandleToObject(obj)
	Return h
End Function


