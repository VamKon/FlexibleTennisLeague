<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadImage.aspx.cs" Inherits="FlexibleTennisLeague.SanJose.Users.UploadImage" %>
<%@ Register Src="~/UserControls/UploadImageControl.ascx" TagName="UploadImageControl" TagPrefix="UIC"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Upload Image</title>
    <link href="/FlexibleTennisLeague/App_Themes/FlexibleTennisLeague/Tennis.css" rel="stylesheet" type="text/css" />
</head>
<body style="width: 450px; height: 250px">
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <UIC:UploadImageControl ID="UploadImageControl1" runat="server" />
    </form>
</body>
</html>
