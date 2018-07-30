<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="CustAccount.aspx.cs" Inherits="OrderSystem.Account.CustAccount" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <link href="Styles/FormCss.css" rel="stylesheet" />
    <script>
        function OnBatchEditStartEdit(s, e) {
            if (e.visibleIndex < 0) {//new mode
                var editor = s.GetEditor("ID"); if (editor != null) editor.SetEnabled(true);
                return;
            }
            var editor = s.GetEditor("ID"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("CreateDate"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("UpdateDate"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("UpdateBy"); if (editor != null) editor.SetEnabled(false);
            editor = s.GetEditor("CreateBy"); if (editor != null) editor.SetEnabled(false);
        }

    </script>
    <div >
            <dx:BootstrapGridView ID="grid" ClientInstanceName="grid" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="ID" OnBatchUpdate="grid_BatchUpdate" OnInitNewRow="grid_InitNewRow" OnRowDeleting="grid_RowDeleting" OnRowInserting="grid_RowInserting" OnRowUpdating="grid_RowUpdating">
                <Settings ShowFilterRow="false" ShowTitlePanel="True" />
                <CssClasses HeaderRow="headerRow" />
                <SettingsBehavior ConfirmDelete="True" />
                <SettingsEditing Mode="Batch">
                </SettingsEditing>
                <SettingsCommandButton>
                    <NewButton Text="New"  IconCssClass="far fa-plus-square"/>
                </SettingsCommandButton>
                <SettingsText Title="CUSTOMER USER ACCOUNT" />
                <SettingsDataSecurity AllowDelete="True" AllowEdit="True" AllowInsert="True" />
                <Columns>
                      <dx:BootstrapGridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0" ShowNewButtonInHeader="True" Width="60px" ShowDeleteButton="True">
                    </dx:BootstrapGridViewCommandColumn>
                    <dx:BootstrapGridViewTextColumn Caption="USER ID" FieldName="ID" VisibleIndex="1">
                    </dx:BootstrapGridViewTextColumn>
                      <dx:BootstrapGridViewTextColumn Caption="NAME" FieldName="Name" VisibleIndex="2">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewTextColumn Caption="PASSWORD" FieldName="PWord" VisibleIndex="3">
                        <PropertiesTextEdit Password="True">
                        </PropertiesTextEdit>
                    </dx:BootstrapGridViewTextColumn> 
                   
                       <dx:BootstrapGridViewComboBoxColumn Caption="CUSTOMER" FieldName="CustomerCode" Width="200" VisibleIndex="5">
                          <PropertiesComboBox DataSourceID="SqlDataSource2" TextField="CustomerName" ValueField="CustomerCode">
                          </PropertiesComboBox>
                      </dx:BootstrapGridViewComboBoxColumn>
                     <dx:BootstrapGridViewComboBoxColumn Caption="TYPE" FieldName="UserType" VisibleIndex="6">
                        <PropertiesComboBox>
                            <Items>
                                <dx:BootstrapListEditItem Text="ADMIN" Value="ADMIN">
                                </dx:BootstrapListEditItem>
                                <dx:BootstrapListEditItem Text="USER" Value="USER">
                                </dx:BootstrapListEditItem>
                            </Items>
                        </PropertiesComboBox>
                    </dx:BootstrapGridViewComboBoxColumn>
                    <dx:BootstrapGridViewComboBoxColumn Caption="STATUS" FieldName="Status" VisibleIndex="7">
                        <PropertiesComboBox>
                            <Items>
                                <dx:BootstrapListEditItem Text="PENDING" Value="PENDING">
                                </dx:BootstrapListEditItem>
                                <dx:BootstrapListEditItem Text="ACTIVE" Value="ACTIVE">
                                </dx:BootstrapListEditItem>
                            </Items>
                        </PropertiesComboBox>
                    </dx:BootstrapGridViewComboBoxColumn>

                        <dx:BootstrapGridViewDateColumn Caption="CREATED" FieldName="CreateDate" VisibleIndex="8">
                    </dx:BootstrapGridViewDateColumn>
                    <dx:BootstrapGridViewTextColumn Caption="CREATED BY" FieldName="CreateBy" VisibleIndex="9">
                    </dx:BootstrapGridViewTextColumn>
                    <dx:BootstrapGridViewDateColumn Caption="UPDATED" FieldName="UpdateDate" VisibleIndex="10">
                    </dx:BootstrapGridViewDateColumn>
                    <dx:BootstrapGridViewTextColumn Caption="UPDATED BY" FieldName="UpdateBy" VisibleIndex="11">
                    </dx:BootstrapGridViewTextColumn>
                
                   
                   
                   
                </Columns>
                <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEdit" />
                <SettingsSearchPanel Visible="True" ShowApplyButton="True" ShowClearButton="True" />
            </dx:BootstrapGridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CustAcct]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [CustomerCode], [CustomerName] FROM [Customer] ORDER BY [CustomerCode]"></asp:SqlDataSource>
        </div>
     <asp:HiddenField ID="hdUserID" runat="server" />
     <asp:HiddenField ID="hdUserType" runat="server" />

</asp:Content>
