<!--- 
As of version 0.2 you can also now POST (setting body only so far) so you can interact with protected web services
like SharePoint. There's no AXIS here, so you'll need to construct your SOAP request body all by yourself.

This example retrieves the contents of a list in the example sharepoint site.

MS Reference
http://msdn.microsoft.com/en-us/library/dd878586%28v=office.12%29.aspx
--->

<!--- create the SOAP request. The list we are retrieving is called 'Tasks' --->
<cfsavecontent variable="soapreq"><?xml version='1.0' encoding='utf-8' ?>
<soap:Envelope  xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/' 
                xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' 
                xmlns:xsd='http://www.w3.org/2001/XMLSchema'>
    <soap:Body>
        <GetListItems xmlns='http://schemas.microsoft.com/sharepoint/soap/'>
            <listName>Tasks</listName>
        </GetListItems>
    </soap:Body>
</soap:Envelope></cfsavecontent>

<!--- we POST the request to the web service. Be sure to set the content type to text/xml --->
<cfscript>
    hr = CreateObject("dotnet", "Com.Bluemini.CF.NetHttpRequest", "#GetDirectoryFromPath(GetCurrentTemplatePath())#\NetHttpRequest.dll");
    hr.setUrl("https://sharepoint.example.com/mysite/_vti_bin/Lists.asmx");
    hr.setUsername("username");
    hr.setPassword("password");
    hr.setMethod("POST");
    hr.setPostBody(soapReq);
    hr.setPostContentType("text/xml");
    response = hr.send();
</cfscript>

<cfif IsXml(response.fileContent)>
    <cfdump var="#XmlParse(response.fileContent)#" label="List Data">
<cfelse>
	<cfdump var="#response#" label="Root Response Struct">
</cfif>