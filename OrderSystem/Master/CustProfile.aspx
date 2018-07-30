<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="CustProfile.aspx.cs" Inherits="OrderSystem.Master.CustProfile" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>
        function OnBatchEditStartEdit(s, e) {
            if (e.visibleIndex < 0) {//new mode
                var editor = s.GetEditor("CustomerCode"); if (editor != null) editor.SetEnabled(true);
                return;
            }
            var editor = s.GetEditor("CustomerCode"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("CreateDate"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("UpdateDate"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("UpdateBy"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("CreateBy"); if (editor != null) editor.SetEnabled(false);
        }

    </script>
   
        <div>
            <dx:BootstrapGridView ID="grid" ClientInstanceName="grid" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="ID" OnBatchUpdate="grid_BatchUpdate" OnInitNewRow="grid_InitNewRow" OnRowDeleting="grid_RowDeleting" OnRowInserting="grid_RowInserting" OnRowUpdating="grid_RowUpdating">
                <Settings ShowFilterRow="True" />
                <CssClasses HeaderRow="headerRow" />
                <SettingsBehavior ConfirmDelete="True" />
                <SettingsEditing Mode="Batch">
                </SettingsEditing>
                <SettingsCommandButton>
                    <NewButton Text="New" IconCssClass="far fa-plus-square" />
                </SettingsCommandButton>
                <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                <Columns>
                    <dx:BootstrapGridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" ShowNewButtonInHeader="True" Width="60px" ShowDeleteButton="True">
                    </dx:BootstrapGridViewCommandColumn>
                    <dx:BootstrapGridViewTextColumn Caption="CODE" FieldName="CustomerCode" VisibleIndex="1" Width="100px">
                        <PropertiesTextEdit MaxLength="20">
                            <ValidationSettings SetFocusOnError="True" ValidationGroup="vgAdd">
                                <RequiredField IsRequired="True" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="NAME" FieldName="CustomerName" VisibleIndex="2" Width="250px">
                        <PropertiesTextEdit MaxLength="200">
                             <ValidationSettings SetFocusOnError="True" ValidationGroup="vgAdd">
                                <RequiredField IsRequired="True" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="STATUS" FieldName="Status" VisibleIndex="5" Width="80px">
                        <PropertiesTextEdit MaxLength="200">
                        </PropertiesTextEdit>
                    </dx:BootstrapGridViewTextColumn>
                     <dx:BootstrapGridViewTextColumn Caption="REMARK" FieldName="Remarks" VisibleIndex="6" Width="200px">
                        <PropertiesTextEdit MaxLength="200">
                             <ValidationSettings SetFocusOnError="True" ValidationGroup="vgAdd">
                                <RequiredField IsRequired="True" />
                            </ValidationSettings>
                        </PropertiesTextEdit>
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewDateColumn Caption="UPDATED" FieldName="UpdateDate" VisibleIndex="10" Width="90px">
                    </dx:BootstrapGridViewDateColumn>
                    <dx:BootstrapGridViewTextColumn Caption="UPDATED BY" FieldName="UpdateBy" VisibleIndex="9" Width="90px">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewDateColumn Caption="CREATED" FieldName="CreateDate" VisibleIndex="8" Width="90px">
                    </dx:BootstrapGridViewDateColumn>
                    <dx:BootstrapGridViewTextColumn Caption="USER ID" FieldName="CreateBy" VisibleIndex="7" Width="90px">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewComboBoxColumn Caption="RESELLER" FieldName="Reseller" VisibleIndex="4" Width="250px">
                        <PropertiesComboBox MaxLength="200" DataSourceID="SqlDataSourceAgent" TextField="ResellerCode" ValueField="ResellerCode">
                            <ValidationSettings SetFocusOnError="True" ValidationGroup="vgAdd">
                                <RequiredField IsRequired="True" />
                            </ValidationSettings>
                        </PropertiesComboBox>
                    </dx:BootstrapGridViewComboBoxColumn>
                </Columns>
                <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEdit" />
                <SettingsSearchPanel Visible="True" ShowApplyButton="True" ShowClearButton="True" />
            </dx:BootstrapGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Customer]"></asp:SqlDataSource>
             <asp:SqlDataSource ID="SqlDataSourceAgent" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ResellerCode FROM [Reseller]"></asp:SqlDataSource>
        </div>
     <asp:HiddenField ID="hdUserID" runat="server" />
      <asp:HiddenField ID="hdUserType" runat="server" />
</asp:Content>

