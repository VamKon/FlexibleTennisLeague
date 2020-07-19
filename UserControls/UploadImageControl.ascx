<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UploadImageControl.ascx.cs" Inherits="FlexibleTennisLeague.UserControls.UploadImageControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<script language="javascript" type="text/javascript">
        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
            else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz az well)
            return oWindow;
        }


        function CloseOnReload() {
            GetRadWindow().Close();
        }


        function RefreshParentPage() {
            GetRadWindow().BrowserWindow.location.reload();
        }
    </script>
<div style="padding: 10px;">
        <p class="heading">
            :: Upload Image</p>
        <telerik:RadUpload ID="RadUpload1" runat="server" MaxFileInputsCount="1" ControlObjectsVisibility="None"
            MaxFileSize="4000000" TargetFolder="~/ProfileImages" AllowedFileExtensions=".jpg,.jpeg,.gif"
            InputSize="45" OverwriteExistingFiles="True">
        </telerik:RadUpload>
        :: Image file size should be less than 4 MB.
        <telerik:RadProgressManager ID="RadProgressManager1" runat="server" />
        <telerik:RadProgressArea ID="RadProgressArea1" runat="server" DisplayCancelButton="True"
            ProgressIndicators="TotalProgressBar">
            <Localization Uploaded="Uploaded"></Localization>
        </telerik:RadProgressArea>
        <br />
        <br />
        <asp:Button ID="uploadButton" runat="server" CssClass="button" Text="Upload" OnClick="uploadButton_Click" /><br />
        <asp:Label ID="errorLabel" runat="server" Text="" ForeColor="Red"></asp:Label>
        <asp:Label ID="InjectScript" runat="server" Text=""></asp:Label>
    </div>