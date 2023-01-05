Class CDUI.Demo.Request.Patient Extends (Ens.Request, %JSON.Adaptor)
{

Property count As %Integer(%JSONFIELDNAME = "_count");

Property page As %Integer(%JSONFIELDNAME = "page");

Property CTSEXDesc As %String;

Property EpisodeNo As %String;

Property PAPERDob As %String;

Property PAPERName As %String;

Property PAPERName2 As %String;

Property PAPERName3 As %String;

Property RegistrationNo As %String;

Property Serialised As %RawString(%JSONINCLUDE = "NONE") [ Transient ];

Index RegistrationNoIndex On RegistrationNo;

Method SerialisedGet() As %RawString
{
	do ..%JSONExportToString(.json)
	return json
}

Storage Default
{
<Data name="PatientDefaultData">
<Subscript>"Patient"</Subscript>
<Value name="1">
<Value>count</Value>
</Value>
<Value name="2">
<Value>page</Value>
</Value>
<Value name="3">
<Value>CTSEXDesc</Value>
</Value>
<Value name="4">
<Value>EpisodeNo</Value>
</Value>
<Value name="5">
<Value>PAPERDob</Value>
</Value>
<Value name="6">
<Value>PAPERName</Value>
</Value>
<Value name="7">
<Value>PAPERName2</Value>
</Value>
<Value name="8">
<Value>PAPERName3</Value>
</Value>
<Value name="9">
<Value>RegistrationNo</Value>
</Value>
</Data>
<DefaultData>PatientDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
