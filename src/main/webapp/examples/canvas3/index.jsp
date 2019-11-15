<%@ page import="canvas.SignedRequest" %>
<%@ page import="java.util.Map" %>
<%
    // Pull the signed request out of the request body and verify/decode it.
    Map<String, String[]> parameters = request.getParameterMap();
    String[] signedRequest = parameters.get("signed_request");
    if (signedRequest == null) {%>
This App must be invoked via a signed request!<%
        return;
    }
    String yourConsumerSecret = "11B2D7FE12CA18B9BB2B2E8C96D755CB603D0DB02B574BF70E84E870F0A188E2";


    String signedRequestJson = SignedRequest.verifyAndDecodeAsJson(signedRequest[0], yourConsumerSecret);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

    <title>Canvas 2</title>

    <link rel="stylesheet" type="text/css" href="/sdk/css/canvas.css"/>

    <!-- Include all the canvas JS dependencies in one file -->
    <script type="text/javascript" src="/scripts/canvas-all.js"></script>
    <!-- Third part libraries, substitute with your own -->
    <script type="text/javascript" src="/scripts/json2.js"></script>

    <script>
        if (self === top) {
            // Not in Iframe
            alert("This canvas app must be included within an iframe");
        }

        Sfdc.canvas(function () {
            var sr = JSON.parse('<%=signedRequestJson%>');
            console.log('sr=>' + sr);
            console.dir(sr);
            // Save the token
            Sfdc.canvas.oauth.token(sr.oauthToken);
            Sfdc.canvas.byId('username').innerHTML = sr.context.user.fullName;
            Sfdc.canvas.byId('email').innerHTML = sr.context.user.email;
            Sfdc.canvas.byId('canvasApp').innerHTML = sr.context.application.name;
            Sfdc.canvas.byId('url2').innerHTML = sr.context.environment.parameters.URL;
            Sfdc.canvas.byId('canvasApp').innerHTML = sr.context.environment.parameters.canvasName;
            Sfdc.canvas.byId('url').innerHTML = sr.context.environment.locationUrl;
            window.location = '/canvas2/index.jsp';
        });

    </script>
</head>
<body>
<br/>
<h1>Canvas3</h1>
<h2>Canvas APP: <span id='canvasApp'></span></h2>
<h2>Username: <span id='username'></span></h2>
<h2>Email: <span id='email'></span></h2>
<h2>URL: <span id='url'></span></h2>
<h2>URL2: <span id='url2'></span></h2>
</body>
</body>
</html>
