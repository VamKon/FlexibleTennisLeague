<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameRating.aspx.cs" Inherits="FlexibleTennisLeague.Common.GameRating"
    Title="Rate Your Game" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Update Match Request</title>
    <link href="../App_Themes/FlexibleTennisLeague/Tennis.css" rel="stylesheet" type="text/css" />
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including clasic dialog
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz az well)
                return oWindow;
            }
            function closeRadWindowAndShowAlert(message) {
                var oWnd = GetRadWindow();
                oWnd.BrowserWindow.radalert(message, 400, null, 'Success'); // The operation is not blocking ;
                // You cannot block this thread ;
                oWnd.close();
            }
        </script>

    </telerik:RadCodeBlock>
</head>
<body style="width: 830px; overflow: hidden">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
    </telerik:RadWindowManager>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="submitButton">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="submitButton" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <br />
    <div class="greyContent" style="width: 820px;" align="center">
        <asp:Label ID="matchLabel" runat="server" Text="Label" Font-Bold="true"></asp:Label>
    </div>
    <p>
    </p>
    <div class="greyContent" style="width: 400px; float: left">
        <p class="heading">
            :: Rate Your Game
        </p>
        <p>
            <table>
                <tr>
                    <td style="height:50px">
                        <b>Serve</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="ownServeRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Forehand</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="ownForehandRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Backhand</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="ownBackhandRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Volley</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="ownVolleyRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Drop</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="ownDropRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Overhead</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="ownOverheadRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Court Coverage</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="ownCourtCoverageRadSlider" runat="server" MaximumValue="5"
                            ItemType="Item" Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
            </table>
        </p>
    </div>
    <div class="greyContent" style="width: 400px; float: right">
        <p class="heading">
            :: Rate Your Opponents Game
        </p>
        <p>
            <table>
                <tr>
                    <td style="height:50px">
                        <b>Serve</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="opponentServeRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Forehand</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="opponentForehandRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Backhand</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="opponentBackhandRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Volley</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="opponentVolleyRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Drop</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="opponentDropRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Overhead</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="opponentOverheadRadSlider" runat="server" MaximumValue="5" ItemType="Item"
                            Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
                <tr>
                    <td style="height:50px">
                        <b>Court Coverage</b>
                    </td>
                    <td style="width: 10px">
                    </td>
                    <td>
                        <telerik:RadSlider ID="opponentCourtCoverageRadSlider" runat="server" MaximumValue="5"
                            ItemType="Item" Width="325" Height="40" TrackPosition="TopLeft" Length="325">
                            <Items>
                                <telerik:RadSliderItem Text="Don't Know" Value="0" ToolTip="Don't Know" runat="server" />
                                <telerik:RadSliderItem Text="Very Bad" Value="1" ToolTip="Very Bad" runat="server" />
                                <telerik:RadSliderItem Text="Bad" Value="2" ToolTip="Bad" runat="server" />
                                <telerik:RadSliderItem Text="Average" Value="3" ToolTip="Average" runat="server" />
                                <telerik:RadSliderItem Text="Good" Value="4" ToolTip="Good" runat="server" />
                                <telerik:RadSliderItem Text="Very Good" Value="5" ToolTip="Very Good" runat="server" />
                            </Items>
                        </telerik:RadSlider>
                    </td>
                </tr>
            </table>
        </p>
    </div>
    <p>
    </p>
    <div class="greyContent" style="width: 830px; clear: both" align="center">
        <asp:Button ID="submitButton" runat="server" Text="Save Ratings" CssClass="button"
            ValidationGroup="validate1" OnClick="submitButton_Click" />
    </div>
    <asp:HiddenField ID="matchIdHiddenField" runat="server" />
    <asp:HiddenField ID="opponentIdHiddenField" runat="server" />
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </form>
</body>
</html>
