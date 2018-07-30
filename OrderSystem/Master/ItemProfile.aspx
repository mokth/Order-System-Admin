<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="ItemProfile.aspx.cs" Inherits="OrderSystem.Master.ItemProfile" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <link href="Styles/FormCss.css" rel="stylesheet" />
    <script>
        function OnBatchEditStartEdit(s, e) {
            if (e.visibleIndex < 0) {//new mode
                var editor = s.GetEditor("ItemCode"); if (editor != null) editor.SetEnabled(true);
                return;
            }
            var editor = s.GetEditor("ItemCode"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("CreateDate"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("UpdateDate"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("UpdateBy"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("CreateBy"); if (editor != null) editor.SetEnabled(false);
        }
        function OnNewClick(s, e) {
            window.location = "ItemEntry.aspx?id=&Type=NEW";
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
                window.location = "ItemEntry.aspx?" + url;
            }
            if (grid.cpUrlView != null) {
                var url = grid.cpUrlView;
                grid.cpUrlView = null;
                window.open("ItemEntry.aspx?" + url, '_blank');
            }
        }
    </script>
    <div >
        <div class="row">
            <div class="col-md-2">
                <dx:BootstrapButton ID="btnNew" runat="server" AutoPostBack="false" CssClasses-Icon="far fa-plus-square" Text="NEW">
                    <CssClasses Control="btn-primary btn-block" />
                    <ClientSideEvents Click="OnNewClick" />
                    <Badge CssClass="btn-primary" />
                </dx:BootstrapButton>
            </div>

        </div>
        <dx:BootstrapGridView ID="grid" ClientInstanceName="grid" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="ID" OnCustomCallback="grid_CustomCallback">
            <Settings ShowTitlePanel="True" />
            <CssClasses HeaderRow="headerRow" />
            <SettingsCommandButton>
                <NewButton Text="New" />
            </SettingsCommandButton>
            <SettingsText Title="ITEM CATEGORY PROFILE" />
            <Columns>
                <dx:BootstrapGridViewCommandColumn VisibleIndex="0" Width="60px">
                    <CustomButtons>
                        <dx:BootstrapGridViewCommandColumnCustomButton ID="VIEW" IconCssClass="far fa-eye"></dx:BootstrapGridViewCommandColumnCustomButton>
                        <dx:BootstrapGridViewCommandColumnCustomButton ID="EDIT" IconCssClass="far fa-edit" />
                        <dx:BootstrapGridViewCommandColumnCustomButton ID="DELETE" IconCssClass="far fa-trash-alt" />
                    </CustomButtons>
                </dx:BootstrapGridViewCommandColumn>

                <dx:BootstrapGridViewTextColumn Caption="CODE" FieldName="ItemCode" VisibleIndex="1" Width="100px">
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn Caption="DESCRIPTION" FieldName="ItemName" VisibleIndex="2" Width="200px">
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewTextColumn Caption="DESCRIPTION" FieldName="ItemNameCN" VisibleIndex="3" Width="200px">
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewComboBoxColumn Caption="TYPE" FieldName="ItemType" VisibleIndex="6" Width="90px">
                </dx:BootstrapGridViewComboBoxColumn>
                <dx:BootstrapGridViewComboBoxColumn Caption="CATEGORY" FieldName="ItemCategory" VisibleIndex="4" Width="90px">
                </dx:BootstrapGridViewComboBoxColumn>
                <dx:BootstrapGridViewComboBoxColumn Caption="UOM" FieldName="ItemUom" VisibleIndex="5" Width="80px">
                </dx:BootstrapGridViewComboBoxColumn>
                <dx:BootstrapGridViewComboBoxColumn Caption="STATUS" FieldName="ItemStatus" VisibleIndex="7" Width="80px">
                </dx:BootstrapGridViewComboBoxColumn>
               <%-- <dx:BootstrapGridViewTextColumn Caption="PROCESS ITEM" FieldName="ProcessItemCode" VisibleIndex="8" Width="100px">
                </dx:BootstrapGridViewTextColumn>
                <dx:BootstrapGridViewCheckColumn Caption="IS PROCESS" FieldName="isProcessItem" VisibleIndex="9" Width="100px">
                </dx:BootstrapGridViewCheckColumn>--%>
                <dx:BootstrapGridViewImageColumn Caption="IMAGE" FieldName="imageUrl" VisibleIndex="8">
                    <PropertiesImage AlternateTextField="ItemCode" ImageAlign="Middle" ImageHeight="200px" ImageUrlFormatString="../ItemImages/{0}" ImageWidth="200px">
                    </PropertiesImage>
                </dx:BootstrapGridViewImageColumn>
            </Columns>
            <Templates>
                <TitlePanel>
                   
                </TitlePanel>
            </Templates>
            <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEdit" CustomButtonClick="OnCustomButClick" EndCallback="OnGridEndCall" />
            <SettingsSearchPanel Visible="True" ShowApplyButton="True" ShowClearButton="True" />
        </dx:BootstrapGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Item]"></asp:SqlDataSource>
         
        </div>
     <asp:HiddenField ID="hdUserID" runat="server" />
      <asp:HiddenField ID="hdUserType" runat="server" />
</asp:Content>

