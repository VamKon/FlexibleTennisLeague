<%@ Page Title="Flexible Tennis League | Denver, CO | Page Of Fame" Language="C#"
    MasterPageFile="~/Denver/FlexibleTennisLeague.Master" AutoEventWireup="true"
    CodeBehind="PageOfFame.aspx.cs" Inherits="FlexibleTennisLeague.Denver.PageOfFame" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="contentGreyTopBorder" style="padding-top: 20px;">
        <h1>
            Flexible Tennis League - Denver's Page of Fame</h1>
        <h2>
            In appreciation of Denver's past and present champions!!</h2>
        <div style="margin-left: auto; margin-right: auto; width: 600px;">
            <div style="float: left; margin-right: 50px;">
                <table class="pofTable">
                    <tr>
                        <td colspan="2" class="pofTopTD">
                            Denver Spring 2010 Division Winner
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="3" class="pofImgTD">
                            <img src="../Resources/Images/DenverSpring2010Winner.jpg" border="0" /><br />
                            Rob Jaecks
                        </td>
                        <td class="pofTD">
                            City: Denver, CO
                        </td>
                    </tr>
                    <tr>
                        <td class="pofTD">
                            Season Record: 6W - 1L
                        </td>
                    </tr>
                    <tr>
                        <td class="pofTD">
                            Member Since: 04/2010
                        </td>
                    </tr>
                </table>
            </div>
            <div style="float: left">
                <table class="pofTable">
                    <tr>
                        <td colspan="2" class="pofTopTD">
                            Denver Fall 2009 Division Winner
                        </td>
                    </tr>
                    <tr>
                        <td rowspan="3" class="pofImgTD">
                            <img src="../Resources/Images/DenverFall2009Winner.jpg" border="0" /><br />
                            Duane Cagle
                        </td>
                        <td class="pofTD">
                            City: Denver, CO
                        </td>
                    </tr>
                    <tr>
                        <td class="pofTD">
                            Season Record: 7W - 1L
                        </td>
                    </tr>
                    <tr>
                        <td class="pofTD">
                            Member Since: 08/2009
                        </td>
                    </tr>
                </table>
            </div>
            <p style="clear:both"></p>
        </div>
    </div>
</asp:Content>
