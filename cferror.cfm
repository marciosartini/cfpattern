<!---
Set a short timeout since this page should not
hog any resources.
--->
<cfsetting requesttimeout="5" />

<!--- Get the query string. --->
<cfset strQueryString = CGI.query_string />

<!--- Check to make sure that we have a 404 error. --->
<cfif Find( "404;", strQueryString )>

<!--- Strip out server name. --->
<cfset strDirectoryPath = ReplaceNoCase( strQueryString, CGI.server_name, "", "ONE" ) />

<!--- Strip out 404 and protocols. --->
<cfset strDirectoryPath = REReplaceNoCase( strDirectoryPath, "(404;)|[a-z]{2,5}://", "", "ALL" ) />

<!--- Remove any query strings. --->
<cfset strDirectoryPath = REReplace( strDirectoryPath, "(\?.*)$", "", "ONE" ) />


<!---
If there is a file being used, get the directory
from teh path.
--->
<cfif REFind( "\.[\w]*$", strDirectoryPath )>

<!--- Remove the file name. --->
<cfset strDirectoryPath = GetDirectoryFromPath( strDirectoryPath ) />

</cfif>


<!---
Set the initial current directory value that will
be check during the loop.
--->
<cfset strCurrentDirectory = strDirectoryPath />


<!---
Loop over the directory path while we still have
directories and look for the cferror.cfm.
--->
<cfloop condition="true">

<!--- Get the directory from the path. --->
<cfset strCurrentDirectory = GetDirectoryFromPath( strCurrentDirectory ) />

<!---
Check to see if we need to break. We don't
want to find THIS cferror.cfm page as that
will just cause a crazy infinite loop. At this
point, just let the page finish to show the
page not found error.
--->
<cfif (Len( strCurrentDirectory ) LTE 1)>
<cfbreak />
</cfif>


<!--- Check to see if the cferror.cfm file exists. --->
<cfif FileExists( ExpandPath( strCurrentDirectory & "cferror.cfm" ) )>

<!---
We found an error template, so relocate to
that template. To make sure our paths are not
crazy, lets cflocation to it and use the same
query string that we got.

CAUTION: This is not how the LIVE server will
handle this action. This is designed for local
error handling on the developmental serer.
--->
<cflocation url="#strCurrentDirectory#cferror.cfm?#CGI.query_string#" addtoken="no" />
<cfbreak />


<!--- Check to see if we can find an application file. --->
<cfelseif (
FileExists( ExpandPath( strCurrentDirectory & "Application.cfm" ) ) OR
FileExists( ExpandPath( strCurrentDirectory & "Application.cfc" ) )
)>

<!---
We didn't find a cferror.cfm page, but we did
hit the root of an application, so break out
of this loop. We don't want to crawl up the
directory any more than we have too. If this
application doesn't catch errors then just stop.
--->
<cfbreak />


<cfelse>

<!---
We didn't find the file or hit any application
roots, so remove the right most slash for next
loop. We do this otherwise the
GetDirectoryFromPath() will not be able to keep
moving up path.
--->
<cfset strCurrentDirectory = REReplace( strCurrentDirectory, "[\\/]{1}$", "", "ALL" ) />

</cfif>

</cfloop>

</cfif>


<!---
If we are still here, then we didn't find a directory
containing a cferror.cfm. Dump out some info to help
the user debug.
--->

<h2>
404 Page Not Found
</h2>

<p>
<cfset WriteOutput( CGI.query_string ) />
</p>

<cfdump var="#CGI#" />