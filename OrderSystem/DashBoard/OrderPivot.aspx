<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="OrderPivot.aspx.cs" Inherits="OrderSystem.DashBoard.OrderPivot" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="EXPORT" OnClick="ASPxButton1_Click" Theme="Office2010Blue"></dx:ASPxButton>
    <dx:ASPxPivotGrid ID="grid" ClientInstanceName="grid" runat="server" ClientIDMode="AutoID" DataSourceID="SqlDataSourceOrder" Theme="Office2010Blue">
    <Fields>
        <dx:PivotGridField ID="fieldpYear" AreaIndex="3" Caption="Year" FieldName="pYear" Name="fieldpYear" Options-ShowInFilter="True">
        </dx:PivotGridField>
        <dx:PivotGridField ID="fieldpMonth" Area="ColumnArea" AreaIndex="0" Caption="Month" FieldName="pMonth" Name="fieldpMonth" Options-ShowInFilter="True">
        </dx:PivotGridField>
        <dx:PivotGridField ID="fieldCustomerCode" AreaIndex="0" FieldName="CustomerCode" Name="fieldCustomerCode" Options-ShowInFilter="True">
        </dx:PivotGridField>
        <dx:PivotGridField ID="fieldCustomerName" AreaIndex="1" FieldName="CustomerName" Name="fieldCustomerName" Options-ShowInFilter="True">
        </dx:PivotGridField>
        <dx:PivotGridField ID="fieldResellerCode" AreaIndex="2" Caption="Reseller" FieldName="ResellerCode" Name="fieldResellerCode" Options-ShowInFilter="True">
        </dx:PivotGridField>
        <dx:PivotGridField ID="fieldItemCode" Area="RowArea" AreaIndex="0" FieldName="ItemCode" Name="fieldItemCode" Options-ShowInFilter="True">
        </dx:PivotGridField>
        <dx:PivotGridField ID="fieldItemName" Area="RowArea" AreaIndex="1" FieldName="ItemName" Name="fieldItemName" Options-ShowInFilter="True">
        </dx:PivotGridField>
        <dx:PivotGridField ID="fieldItemUom" Area="RowArea" AreaIndex="2" Caption="UOM" FieldName="ItemUom" Name="fieldItemUom" Options-ShowInFilter="True">
        </dx:PivotGridField>
        <dx:PivotGridField ID="fieldQuantity" Area="DataArea" AreaIndex="0" CellFormat-FormatType="Numeric" FieldName="Quantity" GrandTotalCellFormat-FormatType="Numeric" Name="fieldQuantity" Options-ShowInFilter="True" TotalCellFormat-FormatType="Numeric" ValueFormat-FormatType="Numeric">
        </dx:PivotGridField>
        <dx:PivotGridField ID="fieldpDay" Area="ColumnArea" AreaIndex="1" Caption="Day" FieldName="pDay" Name="fieldpDay" Options-ShowInFilter="True">
        </dx:PivotGridField>
    </Fields>
        <OptionsPager AlwaysShowPager="True">
            <PageSizeItemSettings Visible="True">
            </PageSizeItemSettings>
        </OptionsPager>
</dx:ASPxPivotGrid>
<asp:SqlDataSource ID="SqlDataSourceOrder" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [vOrderPivot]"></asp:SqlDataSource>
    <dx:ASPxPivotGridExporter ID="ASPxPivotGridExporter1" runat="server" ASPxPivotGridID="grid">
        <OptionsPrint PrintColumnHeaders="True" PrintDataHeaders="True" PrintRowHeaders="True">
            <PageSettings Landscape="True" />
        </OptionsPrint>
    </dx:ASPxPivotGridExporter>
</asp:Content>
