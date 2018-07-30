<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="SalesOrderList.aspx.cs" Inherits="OrderSystem.Sales.SalesOrderList" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>
       .divgrid {
        margin-top:10px;
       }
   </style>
    <script>
        function OnNewClick(s, e) {
            window.location = "SalesOrderEntry.aspx?id=&Type=NEW";
        }
        function OnCustomButClick(s, e) {
            var key = grid.GetRowKey(e.visibleIndex);
            if (e.buttonID == 'EDIT') {
                grid.PerformCallback("EDIT:" + key);
            } else if (e.buttonID == 'DELETE') {
                if (confirm("Confirm to delete this record?")) {
                    grid.PerformCallback("DELETE:" + key);
                }
            } else if (e.buttonID == 'VIEW') {
                grid.PerformCallback("VIEW:" + key);
            }
        }
        function OnGridEndCall(s, e) {
            if (grid.cpUrl != null) {
                var url = grid.cpUrl;
                grid.cpUrl = null;
                window.location = "SalesOrderEntry.aspx?"+url;
            }
            if (grid.cpUrlView != null) {
                var url = grid.cpUrlView;
                grid.cpUrlView = null;
                window.open("SalesOrderEntry.aspx?" + url,'_blank');
            }
        }

    </script>
    <div class="row">
        <div class="col-md-2">
            <dx:BootstrapButton ID="btnNew" runat="server" AutoPostBack="false" CssClasses-Icon="far fa-plus-square" Text="NEW">
                <CssClasses Control="btn-primary btn-block" />
                <ClientSideEvents Click="OnNewClick" />
                <Badge CssClass="btn-primary" />
            </dx:BootstrapButton>
        </div>

    </div>
    <div class="divgrid">
    <dx:BootstrapGridView ID="grid" ClientInstanceName="grid" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="ID" OnCustomCallback="grid_CustomCallback" >
                <CssClasses HeaderRow="headerRow" />
                <SettingsBootstrap Sizing="Small" />
                <SettingsText Title="SALES ORDER LISTING" />
                <Settings ShowTitlePanel="True" ShowFilterRow="True" ShowHeaderFilterButton="True" />
                
                <Columns>
                    <dx:BootstrapGridViewCommandColumn Caption=" " VisibleIndex="0" Width="50px" ShowClearFilterButton="True">
                        <CustomButtons>
                            <dx:BootstrapGridViewCommandColumnCustomButton ID="VIEW" IconCssClass="far fa-eye">                              
                            </dx:BootstrapGridViewCommandColumnCustomButton >
                            <dx:BootstrapGridViewCommandColumnCustomButton ID="EDIT"  IconCssClass="far fa-edit" />
                             <dx:BootstrapGridViewCommandColumnCustomButton ID="DELETE"  IconCssClass="far fa-trash-alt" />
                        </CustomButtons>
                    </dx:BootstrapGridViewCommandColumn>
                       <dx:BootstrapGridViewDateColumn Caption="ORDER DATE" FieldName="OrderDate" VisibleIndex="1">
                    </dx:BootstrapGridViewDateColumn>
                    <dx:BootstrapGridViewTextColumn Caption="ORDER NO" FieldName="OrderNo" VisibleIndex="2">
                                          </dx:BootstrapGridViewTextColumn>
                     <dx:BootstrapGridViewTextColumn Caption="CUST CODE" FieldName="CustomerCode" VisibleIndex="3">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="CUST NAME" FieldName="CustomerName" VisibleIndex="4">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="STATUS" FieldName="OrderStatus" VisibleIndex="5">
                    </dx:BootstrapGridViewTextColumn>
                   
                 
                   
                    <dx:BootstrapGridViewTextColumn Caption="RESELLER" FieldName="ResellerCode" VisibleIndex="6">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="ACCT STATUS" FieldName="AccountStatus" VisibleIndex="7">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="TYPE" FieldName="OrderType" VisibleIndex="8">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewDateColumn Caption="UPDATED" FieldName="UpdateDate" VisibleIndex="13">
                    </dx:BootstrapGridViewDateColumn>
                    <dx:BootstrapGridViewTextColumn Caption="UPDATED BY" FieldName="UpdateBy" VisibleIndex="12">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewDateColumn Caption="CREATED DATE" FieldName="CreateDate" VisibleIndex="11">
                    </dx:BootstrapGridViewDateColumn>
                    <dx:BootstrapGridViewTextColumn Caption="CREATED BY" FieldName="CreateBy" VisibleIndex="10">
                    </dx:BootstrapGridViewTextColumn>
                    
                </Columns>
                <Templates>
                    <TitlePanel>
                       
                    </TitlePanel>
                </Templates>
               
                <ClientSideEvents CustomButtonClick="OnCustomButClick" EndCallback="OnGridEndCall" />
                <SettingsSearchPanel Visible="True" ShowApplyButton="True" ShowClearButton="True" />
            </dx:BootstrapGridView>
    </div>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [OrderHdr]"></asp:SqlDataSource>
     <asp:HiddenField ID="hdUserID" runat="server" />
      <asp:HiddenField ID="hdUserType" runat="server" />
</asp:Content>

