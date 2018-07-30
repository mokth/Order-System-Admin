<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="DailyOrder.aspx.cs" Inherits="OrderSystem.DashBoard.DailyOrder" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        function OnSearch(s, e) {
            callpanel.PerformCallback("SEARCH");
        }
        function OnEndcall(s, e) {
            if (callpanel.cpData != null) {
                callpanel.cpData = null;
                grid.Refresh();
            }
        }

    </script>
    <dx:ASPxCallbackPanel ID="callpanel" ClientInstanceName="callpanel" runat="server" Width="200px" OnCallback="callpanel_Callback" Theme="Office2010Blue">
        <ClientSideEvents EndCallback="OnEndcall" />
        <PanelCollection>
            <dx:PanelContent runat="server">
                <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="3" Width="500px">
                    <Items>
                        <dx:LayoutItem Caption="Date From">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="txtDateFr" ClientInstanceName="txtDateFr" runat="server">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem Caption="Date To">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxDateEdit ID="txtDateTo" ClientInstanceName="txtDateto" runat="server">
                                    </dx:ASPxDateEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxButton ID="btnSearch" ClientInstanceName="btnSearch" runat="server" AutoPostBack="False" Text="Search" Width="100px">
                                        <Image IconID="zoom_zoom_16x16">
                                        </Image>
                                        <ClientSideEvents Click="OnSearch" />
                                    </dx:ASPxButton>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:ASPxFormLayout>
            </dx:PanelContent>
        </PanelCollection>

    </dx:ASPxCallbackPanel>
    
    <dx:ASPxGridView ID="grid" ClientInstanceName="grid" runat="server" AutoGenerateColumns="False" Theme="Office2010Blue">
        <SettingsAdaptivity AdaptivityMode="HideDataCellsWindowLimit">
        </SettingsAdaptivity>
        <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowHeaderFilterButton="True" />
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="CustomerCode" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CustomerName" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Reseller" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="OrderNo" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="OrderStatus" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="OrderDate" VisibleIndex="6">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="Remark" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ItemCode" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ItemName" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ItemNameCN" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ItemUom" VisibleIndex="12">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>
    
</asp:Content>
