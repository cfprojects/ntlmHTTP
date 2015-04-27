<!---
Good blog post for 'DotNet side does not seem to be running error'
http://blogs.adobe.com/vikaschandran/2010/12/22/how-to-resolve-error-dotnet-side-does-not-seem-to-be-running-with-coldfusion-901-on-windows/

Possibly useful if getting fileNotFound exceptions
http://blog.daksatech.com/2010/05/coldfusion-net-integration-service-on.html

MSDN Article on System.Net which includes the HTTP stuff used below
http://msdn.microsoft.com/en-us/library/gg145039.aspx
--->


<!--- setup the .Net dll as a CF object --->
<cfset NetRequest = CreateObject("dotnet", "Com.Bluemini.CF.NetHttpRequest", "#GetDirectoryFromPath(GetCurrentTemplatePath())#\NetHttpRequest.dll")>

<!--- call MakeRequest(String url, String username, String password) --->
<cfset resp = NetRequest.MakeRequest(JavaCast("String", "http://www.protected.com/"),
                                     JavaCast("String", "username"),
                                     JavaCast("String", "password"))>
<cfdump var="#resp#">

<!--- however, you can be more CF like and treat the .Net class like a scripted http in CF --->
<cfscript>
    hr = CreateObject("dotnet", "Com.Bluemini.CF.NetHttpRequest", "#GetDirectoryFromPath(GetCurrentTemplatePath())#\NetHttpRequest.dll");
    hr.setUrl("https://www.protected.com/secure/show_detail.aspx");
    hr.setUsername("username");
    hr.setPassword("password");
    response = hr.send();
</cfscript>
<cfdump var="#response#">