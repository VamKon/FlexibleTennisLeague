<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PerformanceControl.ascx.cs" Inherits="FlexibleTennisLeague.UserControls.PerformanceControl" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="cc1" %>
<div class="greyContent">
        <table width="800">
            <tr>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    Season Wins:&nbsp;<asp:Label ID="seasonWinsLabel" runat="server" Text=""></asp:Label>
                </td>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    Season Points:&nbsp;<asp:Label ID="seasonPointsLabel" runat="server" Text=""></asp:Label>
                </td>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    Overall Wins:&nbsp;<asp:Label ID="overallWinsLabel" runat="server" Text=""></asp:Label>
                </td>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    Overall Points:&nbsp;<asp:Label ID="overallPointsLabel" runat="server" Text=""></asp:Label>
                </td>
                
            </tr>
        </table>
    </div>
    <br />
    <div class="greyContent">
        <table width="800">
            <tr>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    Serve:&nbsp;<span><i>Serve</i></span>
                </td>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    F'Hand:&nbsp;<span><i>Forehand</i></span>
                </td>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    B'Hand:&nbsp;<span><i>Backhand</i></span>
                </td>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    Volley:&nbsp;<span><i>Volley</i></span>
                </td>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    Drop:&nbsp;<span><i>Drop</i></span>
                </td>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    O'Head:&nbsp;<span><i>Overhead</i></span>
                </td>
                <td class="signUpBoldNoWidth" style="text-align: center">
                    Cover:&nbsp;<span><i>Court Coverage</i></span>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div class="greyContent" style="width:48%;float:left">
        <telerik:RadChart ID="ownPerformanceRadChart" runat='server' AutoLayout="True">
            <Series>
                <cc1:ChartSeries Name="My Game">
                    <Appearance>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
            </Series>
            <PlotArea>
                <EmptySeriesMessage>
                    <TextBlock Text="No matches have been rated.">
                    </TextBlock>
                </EmptySeriesMessage>
            </PlotArea>
            <ChartTitle>
                <TextBlock Text="How I Feel About My Game">
                    <Appearance TextProperties-Font="Verdana, 12pt, style=Bold">
                    </Appearance>
                </TextBlock>
            </ChartTitle>
            <Legend Visible="False">
                <Appearance Visible="False">
                </Appearance>
            </Legend>
        </telerik:RadChart>
    </div>
    <div class="greyContent" style="width:48%;float:right">
    <telerik:RadChart ID="opponentPerformanceRadChart" runat='server' AutoLayout="True">
            <Series>
                <cc1:ChartSeries Name="My Game">
                    <Appearance>
                        <FillStyle MainColor="White" SecondColor="Orange">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
            </Series>
            <PlotArea>
                <EmptySeriesMessage>
                    <TextBlock Text="No matches have been rated.">
                    </TextBlock>
                </EmptySeriesMessage>
            </PlotArea>
            <ChartTitle>
                <TextBlock Text="How Others Feel About My Game">
                    <Appearance TextProperties-Font="Verdana, 12pt, style=Bold">
                    </Appearance>
                </TextBlock>
            </ChartTitle>
            <Legend Visible="False">
                <Appearance Visible="False">
                </Appearance>
            </Legend>
        </telerik:RadChart>
    </div>
    <div style="clear:both"><p></p></div>
    <div class="greyContent">
        <telerik:RadChart ID="ownPerformanceDetailRadChart" runat='server' AutoLayout="True" 
            DefaultType="Line" Height="350px" Width="825px">
            <Series>
                <cc1:ChartSeries Name="Serve" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Red">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Forehand" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Green">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Backhand" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Blue">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Volley" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Violet">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Drop" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Yellow">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Overhead" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Cyan">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Court Coverage" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="White">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
            </Series>
            <PlotArea>
                <EmptySeriesMessage>
                    <TextBlock Text="No matches have been rated.">
                    </TextBlock>
                </EmptySeriesMessage>
            </PlotArea>
            <ChartTitle>
                <TextBlock Text="How I Feel About My Game">
                    <Appearance TextProperties-Font="Verdana, 12pt, style=Bold">
                    </Appearance>
                </TextBlock>
            </ChartTitle>
            <Legend>
                <Appearance Position-AlignedPosition="Bottom" Overflow="Row">
                </Appearance>
            </Legend>
        </telerik:RadChart>
    </div>
    <p></p>
    <div class="greyContent" >
        <telerik:RadChart ID="othersPerformanceDetailRadChart" runat='server' AutoLayout="True" 
            DefaultType="Line" Height="350px" Width="825px">
            <Series>
                <cc1:ChartSeries Name="Serve" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Red">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Forehand" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Green">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Backhand" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Blue">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Volley" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Violet">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Drop" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Yellow">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Overhead" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="Cyan">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
                <cc1:ChartSeries Name="Court Coverage" Type="Bar">
                    <Appearance>
                        <FillStyle MainColor="White">
                        </FillStyle>
                        <LabelAppearance Visible="False">
                        </LabelAppearance>
                    </Appearance>
                </cc1:ChartSeries>
            </Series>
            <PlotArea>
                <EmptySeriesMessage>
                    <TextBlock Text="No matches have been rated.">
                    </TextBlock>
                </EmptySeriesMessage>
            </PlotArea>
            <ChartTitle>
                <TextBlock Text="How Others Feel About My Game">
                    <Appearance TextProperties-Font="Verdana, 12pt, style=Bold">
                    </Appearance>
                </TextBlock>
            </ChartTitle>
            <Legend>
                <Appearance Position-AlignedPosition="Bottom" Overflow="Row">
                </Appearance>
            </Legend>
        </telerik:RadChart>
    </div>