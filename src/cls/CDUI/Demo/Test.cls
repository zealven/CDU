Include %syPrompt

Class CDUI.Demo.Test
{

ClassMethod List(StartsWith As %String = "", PageSize As %Integer = "", ByRef Page As %Integer = "", ByRef Results) As %Status
{
	set request = ##class(CDUI.Demo.Request.Location).%New()
	set request.Description = StartsWith
	if Page'=""
	{
		set request.page = Page
	}
	if PageSize'=""
	{
		set request.count = PageSize
	}
	#; ,request.HospitalDesc = Desc
	set sc = ##class(Ens.Director).CreateBusinessService("CDUI.Demo.Service.Adaptorless",.svc)
	set sc = $$$ADDSC(sc,svc.ProcessInput(request,.response))
	if $$$ISOK(sc)
	{
		set json = {}.%FromJSON(response.StringValue)
		set iterator = json.results.%GetIterator()
		while iterator.%GetNext(.key,.value)
		{	
			set Results($increment(Results)) = $listbuild(value.CTLOCCode,value.CTLOCDesc)
		}
	}
	quit sc
}

ClassMethod ListLocations()
{
	set promptResult = ##class(%Prompt).GetString("Search for location starting with : ",.value)
	set sc = ..List(value,24,.page,.results)
	set i = ""
	for
	{
		set i = $order(results(i),1,location)
		quit:i=""
		set code = $listget(location),codelen = $length(code)
		write !,$listget(location,1)_$justify("",(15-codelen))_" : "_$listget(location,2)
	}
}

ClassMethod NewLocation()
{
	set CTLOCCode = "Z"_##class(%PopulateUtils).String(5)
	set CTLOCDesc = $zconvert($translate(##class(%PopulateUtils).Syllable(10)," "),"S")
	set request = ##class(CDUI.Demo.Request.NewLocation).%New()
	set request.CTLOCCode = CTLOCCode,request.CTLOCDesc = CTLOCDesc
	set sc = ##class(Ens.Director).CreateBusinessService("CDUI.Demo.Service.Adaptorless",.svc)
	set sc = $$$ADDSC(sc,svc.ProcessInput(request,.response))
	if $$$ISOK(sc)
	{
		set json = {}.%FromJSON(response.StringValue)
		write !,"Created CT_Loc RowID "_json.ID
	}
	quit sc
}

ClassMethod NewPatient(number)
{
	f i=1:1:number
	{
		k sex
		s sex(1)="Male"
		s sex(2)="Female"
		s sex=$R(2)+1
		set PAPERName =##class(%PopulateUtils).LastName()
		set PAPERName2 =##class(%PopulateUtils).FirstName(sex)
		s CTSEXDesc=sex(sex)
		s PAPERDob=##class(%PopulateUtils).Date($zdh("1/1/1930",4),+$h)
		set request = ##class(CDUI.Demo.Request.NewPatient).%New()
		set request.PAPERName = PAPERName
		set request.PAPERName2 = PAPERName2
		s request.PAPERDob=PAPERDob
		s request.CTSEXDesc=CTSEXDesc
		set sc = ##class(Ens.Director).CreateBusinessService("CDUI.Demo.Service.Adaptorless",.svc)
		set sc = $$$ADDSC(sc,svc.ProcessInput(request,.response))
		if $$$ISOK(sc)
		{
			set json = {}.%FromJSON(response.StringValue)
			write !,"Created PA_Person RowID "_json.ID_". Name:"_PAPERName_" "_PAPERName2
		}
	}
	quit sc
}

}
