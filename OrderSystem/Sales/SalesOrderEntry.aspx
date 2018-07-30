<%@ Page Language="C#"  MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="SalesOrderEntry.aspx.cs" Inherits="OrderSystem.Sales.SalesOrderEntry" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <style>
         .callpanel{
             padding:10px;
             border-style:solid;
             border-width:1px;
             border-color:lightgray;
         }
     </style>
     <script>
         function OnItemButtonClick(s, e) {
            
             popUp.Show();
         }
         function onCustButClick(s, e) {
             popCust.Show();
         }
         function OngridItemRowClick(s, e) {
             if (e.visibleIndex < 0) {
                 return;
             }
             gridItem.GetRowValues(e.visibleIndex, "ItemCode;ItemName;ItemUom", function (val) {
                 var index = hdGridRowIndex.GetText();// gridMac.GetFocusedRowIndex();
                 console.log(val[0]);

                 grid.batchEditApi.SetCellValue(index, "ItemCode", val[0]);
                 grid.batchEditApi.SetCellValue(index, "ItemName", val[1]);
                 grid.batchEditApi.SetCellValue(index, "ItemUom", val[2]);
                 grid.batchEditApi.SetCellValue(index, "Quantity", 1);
                 grid.batchEditApi.ValidateRow(index);
                 popUp.Hide();
             });
         }
         function OngridCustRowClick(s, e) {
             if (e.visibleIndex < 0) {
                 return;
             }
             gridCust.GetRowValues(e.visibleIndex, "CustomerCode;CustomerName;Reseller", function (val) {
                 var index = hdGridRowIndex.GetText();// gridMac.GetFocusedRowIndex();
                 txtCustCode.SetText(val[0]);
                 txtCustName.SetText(val[1]);
                 txtAgent.SetText(val[2]);
                 popCust.Hide();
             });
         }
         function OnNewClick(s, e) {
             if (grid.batchEditApi.HasChanges()) {
                 grid.UpdateEdit();
                 grid.PerformCallback("ADDNEW:");
             } else {
                 grid.AddNewRow();
             }
         }
         function OnSaveClick(s, e) {
             if (!ASPxClientEdit.ValidateGroup("vgAdd")) {
                 return;
             }
             callback.PerformCallback("SAVE:");
         }
         function OnCancelClick(s, e) {
             window.location = "SalesOrderList.aspx";
         }
         function onCallPanelEndCall(s, e) {
             if (callback.cpErr != null) {
                 alert(callback.cpErr);
                 callback.cpErr = null;
             }
         }
         function OngridEndCall(s, e) {
             if (grid.cpErr != null) {
                 alert(grid.cpErr);
                 grid.cpErr = null;
             }
             if (grid.cNew != null) {
                 grid.cpNew = null;
                 grid.AddNewRow();
             }
         }
         function OnBatchEditStartEdit(s, e) {
             hdGridRowIndex.SetText(e.visibleIndex);
             console.log('OnBatchEditStartEdit');
             console.log(e.visibleIndex);
            if (e.visibleIndex < 0) {//new mode
                var editor = s.GetEditor("ItemCode"); if (editor != null) editor.SetEnabled(true);
                return;
            }
            var editor = s.GetEditor("ItemCode"); if (editor != null) editor.SetEnabled(false);
          
        }

    </script>
     <div>
         <dx:BootstrapCallbackPanel ID="callback" runat="server" ClientInstanceName="callback" OnCallback="callback_Callback">
             <ContentCollection>
                 <dx:ContentControl runat="server">
                     <dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" ShowItemCaptionColon="False">
                         <SettingsItemCaptions HorizontalAlign="Left" />
                         <SettingsItems HorizontalAlign="Left" />
                         <Items>
                             <dx:BootstrapLayoutItem Caption="ORDER NO">
                                 <ContentCollection>
                                     <dx:ContentControl runat="server">
                                         <dx:BootstrapTextBox ID="txtOrderNo" ClientInstanceName="txtOrderNo" runat="server">
                                             <ValidationSettings ValidationGroup="vgAdd">
                                                 <RequiredField IsRequired="True" />
                                             </ValidationSettings>
                                         </dx:BootstrapTextBox>
                                     </dx:ContentControl>
                                 </ContentCollection>
                             </dx:BootstrapLayoutItem>
                             <dx:BootstrapLayoutItem Caption="STATUS">
                                 <ContentCollection>
                                     <dx:ContentControl runat="server">
                                         <dx:BootstrapTextBox ID="txtStatus" ClientInstanceName="txtStatus" runat="server">
                                         </dx:BootstrapTextBox>
                                     </dx:ContentControl>
                                 </ContentCollection>
                             </dx:BootstrapLayoutItem>
                             <dx:BootstrapLayoutItem Caption="ORDER DATE">
                                 <ContentCollection>
                                     <dx:ContentControl runat="server">
                                         <dx:BootstrapDateEdit ID="txtDate" ClientInstanceName="txtDate" runat="server">
                                             <ValidationSettings ValidationGroup="vgAdd">
                                                 <RequiredField IsRequired="True" />
                                             </ValidationSettings>
                                         </dx:BootstrapDateEdit>
                                     </dx:ContentControl>
                                 </ContentCollection>
                             </dx:BootstrapLayoutItem>
                             <dx:BootstrapLayoutItem Caption="ORDER TYPE">
                                 <ContentCollection>
                                     <dx:ContentControl runat="server">
                                         <dx:BootstrapComboBox ID="txtType" ClientInstanceName="txtType" runat="server">
                                         </dx:BootstrapComboBox>
                                     </dx:ContentControl>
                                 </ContentCollection>
                             </dx:BootstrapLayoutItem>
                             <dx:BootstrapLayoutItem Caption="CUSTOMER">
                                 <ContentCollection>
                                     <dx:ContentControl runat="server">
                                         <dx:BootstrapButtonEdit ID="txtCustCode" ClientInstanceName="txtCustCode" runat="server">
                                             <Buttons>
                                                 <dx:BootstrapEditButton />
                                             </Buttons>
                                              <ValidationSettings ValidationGroup="vgAdd">
                                                 <RequiredField IsRequired="True" />
                                             </ValidationSettings>
                                             <ClientSideEvents ButtonClick="onCustButClick" />
                                         </dx:BootstrapButtonEdit>
                                     </dx:ContentControl>
                                 </ContentCollection>
                             </dx:BootstrapLayoutItem>
                             <dx:BootstrapLayoutItem Caption="NAME">
                                 <ContentCollection>
                                     <dx:ContentControl runat="server">
                                         <dx:BootstrapTextBox ID="txtCustName" ClientInstanceName="txtCustName" ReadOnly="true" runat="server">
                                             <ValidationSettings ValidationGroup="vgAdd">
                                                 <RequiredField IsRequired="True" />
                                             </ValidationSettings>
                                         </dx:BootstrapTextBox>
                                     </dx:ContentControl>
                                 </ContentCollection>
                             </dx:BootstrapLayoutItem>
                             <dx:BootstrapLayoutItem Caption="RESELLER">
                                 <ContentCollection>
                                     <dx:ContentControl runat="server">
                                         <dx:BootstrapComboBox ID="txtAgent" ClientInstanceName="txtAgent" runat="server" DataSourceID="SqlDataSourceAgent" TextField="ResellerCode" ValueField="ResellerCode">
                                              <ValidationSettings ValidationGroup="vgAdd">
                                                 <RequiredField IsRequired="True" />
                                             </ValidationSettings>
                                          </dx:BootstrapComboBox>
                                         <asp:SqlDataSource ID="SqlDataSourceAgent" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ResellerCode] FROM [Reseller]"></asp:SqlDataSource>
                                     </dx:ContentControl>
                                 </ContentCollection>
                             </dx:BootstrapLayoutItem>
                             <dx:BootstrapLayoutItem Caption="REMARK">
                                 <ContentCollection>
                                     <dx:ContentControl runat="server">
                                         <dx:BootstrapMemo ID="txtRemark" ClientInstanceName="txtRemark" runat="server">
                                         </dx:BootstrapMemo>
                                     </dx:ContentControl>
                                 </ContentCollection>
                             </dx:BootstrapLayoutItem>
                         </Items>
                     </dx:BootstrapFormLayout>
                     <div class="row">
                         <div class="col-md-2">
                             <dx:BootstrapButton ID="btnSave" ClientInstanceName="btnSave" runat="server" CssClasses-Icon="far fa-save" AutoPostBack="false" Text="SAVE">
                                 <CssClasses Control="btn-info btn-block"  />
                                 <ClientSideEvents Click="OnSaveClick" />
                             </dx:BootstrapButton>
                         </div>
                          <div class="col-md-2">
                              <dx:BootstrapButton ID="btnCancel" ClientInstanceName="btnCancel" runat="server"  CssClasses-Icon="fas fa-ban" AutoPostBack="false" Text="CANCEL">
                                  <CssClasses Control="btn-danger btn-block" />
                                  <ClientSideEvents Click="OnCancelClick" />
                              </dx:BootstrapButton>
                         </div>
                     </div>
                 </dx:ContentControl>
             </ContentCollection>
             <CssClasses Control="callpanel" />
             <ClientSideEvents EndCallback="onCallPanelEndCall" />
         </dx:BootstrapCallbackPanel>
         
         <dx:BootstrapGridView ID="grid" ClientInstanceName="grid" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" KeyFieldName="ID" OnBatchUpdate="grid_BatchUpdate" OnRowDeleting="grid_RowDeleting" OnRowInserting="grid_RowInserting" OnRowUpdating="grid_RowUpdating" OnCustomCallback="grid_CustomCallback">
             <Settings ShowTitlePanel="True" />
             <SettingsEditing Mode="Batch">
             </SettingsEditing>
             <SettingsText Title="ORDER ITEM LISTING" />
             <SettingsDataSecurity AllowDelete="True" AllowInsert="True" AllowEdit="True" />
             <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEdit" EndCallback="OngridEndCall" />
             <Columns>
                <%-- <dx:BootstrapGridViewTextColumn Caption="LINE" FieldName="OrderLine" VisibleIndex="2" Width="50px">
                 </dx:BootstrapGridViewTextColumn>--%>
                 <dx:BootstrapGridViewCommandColumn Caption=" " ShowDeleteButton="True" ShowNewButtonInHeader="True" VisibleIndex="0" Width="60px" ButtonRenderMode="Image" ButtonType="Image">
                     <HeaderTemplate>
                         <dx:BootstrapButton ID="btnNew" runat="server" AutoPostBack="False" CommandName="btnNew" CssClasses-Icon="far fa-plus-square">
                             <CssClasses Control="btn-info" />
                             <ClientSideEvents Click="OnNewClick" />
                         </dx:BootstrapButton>
                     </HeaderTemplate>                     
                 </dx:BootstrapGridViewCommandColumn>
                
                 <dx:BootstrapGridViewTextColumn Caption="UOM" FieldName="ItemUom" VisibleIndex="8">
                     
                     <PropertiesTextEdit>
                         <ValidationSettings ValidationGroup="vgItem">
                             <RequiredField IsRequired="True" />
                         </ValidationSettings>
                     </PropertiesTextEdit>
                     
                 </dx:BootstrapGridViewTextColumn>
                 <dx:BootstrapGridViewTextColumn Caption="ITEM NAME" FieldName="ItemName" VisibleIndex="6">
                     <PropertiesTextEdit>
                         <ValidationSettings ValidationGroup="vgItem">
                             <RequiredField IsRequired="True" />
                         </ValidationSettings>
                     </PropertiesTextEdit>
                 </dx:BootstrapGridViewTextColumn>
                 <dx:BootstrapGridViewTextColumn Caption="QUANTITY" FieldName="Quantity" VisibleIndex="7">
                     <PropertiesTextEdit>
                         <ValidationSettings ValidationGroup="vgItem">
                             <RequiredField IsRequired="True" />
                         </ValidationSettings>
                     </PropertiesTextEdit>
                 </dx:BootstrapGridViewTextColumn>
                 <dx:BootstrapGridViewTextColumn Caption="REMARK" FieldName="Remark" VisibleIndex="9">
                 </dx:BootstrapGridViewTextColumn>
                 <dx:BootstrapGridViewButtonEditColumn Caption="ITEM CODE" FieldName="ItemCode" ReadOnly="True" VisibleIndex="5">
                     <PropertiesButtonEdit>
                         <ValidationSettings ValidationGroup="vgItem">
                             <RequiredField IsRequired="True" />
                         </ValidationSettings>
                         <Buttons>
                             <dx:BootstrapEditButton />
                         </Buttons>
                         <ClientSideEvents ButtonClick="OnItemButtonClick" />
                     </PropertiesButtonEdit>
                 </dx:BootstrapGridViewButtonEditColumn>
             </Columns>
              <SettingsCommandButton>
                  <DeleteButton IconCssClass="far fa-trash-alt" />
                 </SettingsCommandButton>
         </dx:BootstrapGridView>
         <dx:BootstrapPopupControl ID="popUp" ClientInstanceName="popUp" runat="server" AllowDragging="True" AllowResize="True" CloseAction="CloseButton" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px">
             <ContentCollection>
                 <dx:ContentControl runat="server">
                     <dx:BootstrapGridView ID="gridItem" runat="server" DataSourceID="SqlDataSourceItem" AutoGenerateColumns="False" ClientInstanceName="gridItem" KeyFieldName="ID">
                         <Settings ShowFilterRow="True" />
                         <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                         <Columns>
                             <dx:BootstrapGridViewTextColumn Caption="ITEM CODE" FieldName="ItemCode" VisibleIndex="2">
                             </dx:BootstrapGridViewTextColumn>
                             <dx:BootstrapGridViewTextColumn Caption="NAME" FieldName="ItemName" VisibleIndex="3">
                             </dx:BootstrapGridViewTextColumn>
                             <dx:BootstrapGridViewTextColumn Caption="NAME" FieldName="ItemNameCN" VisibleIndex="4">
                             </dx:BootstrapGridViewTextColumn>
                             <dx:BootstrapGridViewTextColumn Caption="TYPE" FieldName="ItemType" VisibleIndex="5">
                             </dx:BootstrapGridViewTextColumn>
                             <dx:BootstrapGridViewTextColumn Caption="CATEGORY" FieldName="ItemCategory" VisibleIndex="6">
                             </dx:BootstrapGridViewTextColumn>
                             <dx:BootstrapGridViewTextColumn Caption="UOM" FieldName="ItemUom" VisibleIndex="7">
                             </dx:BootstrapGridViewTextColumn>
                         </Columns>
                         <ClientSideEvents RowClick="OngridItemRowClick" />
                         <SettingsSearchPanel Visible="True" />
                     </dx:BootstrapGridView>
                 </dx:ContentControl>
             </ContentCollection>
         </dx:BootstrapPopupControl>

          <dx:BootstrapPopupControl ID="popCust" ClientInstanceName="popCust" runat="server" AllowDragging="True" AllowResize="True" CloseAction="CloseButton" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="800px">
             <ContentCollection>
                 <dx:ContentControl runat="server">
                     <dx:BootstrapGridView ID="gridCust" runat="server"  AutoGenerateColumns="False" ClientInstanceName="gridCust" KeyFieldName="CustomerCode" DataSourceID="SqlDataSourceCust" >
                         <Settings ShowFilterRow="True" />
                         <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                         <Columns>
                           
                             <dx:BootstrapGridViewTextColumn Caption="CODE" FieldName="CustomerCode" VisibleIndex="0">
                             </dx:BootstrapGridViewTextColumn>
                             <dx:BootstrapGridViewTextColumn Caption="NAME" FieldName="CustomerName" VisibleIndex="1">
                             </dx:BootstrapGridViewTextColumn>
                             <dx:BootstrapGridViewTextColumn Caption="RESELLER" FieldName="Reseller" VisibleIndex="2">
                             </dx:BootstrapGridViewTextColumn>
                           
                         </Columns>
                         <ClientSideEvents RowClick="OngridCustRowClick" />
                         <SettingsSearchPanel Visible="True" />
                     </dx:BootstrapGridView>
                     <asp:SqlDataSource ID="SqlDataSourceCust" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [CustomerCode], [CustomerName], [Reseller] FROM [Customer]"></asp:SqlDataSource>
                 </dx:ContentControl>
             </ContentCollection>
         </dx:BootstrapPopupControl>
         <dx:BootstrapTextBox ID="hdGridRowIndex" ClientInstanceName="hdGridRowIndex" runat="server" ClientVisible="false"></dx:BootstrapTextBox>
         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [OrderDtl] WHERE ([OrderNo] =@OrderNo)">
             <SelectParameters>
                 <asp:ControlParameter ControlID="ctl00$ContentPlaceHolder1$callback$BootstrapFormLayout1$txtOrderNo" Name="OrderNo" PropertyName="Text" Type="String" />
             </SelectParameters>
         </asp:SqlDataSource>
           <asp:SqlDataSource ID="SqlDataSourceItem" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Item]"></asp:SqlDataSource>
     </div>
     <asp:HiddenField ID="hdUserID" runat="server" />
      <asp:HiddenField ID="hdUserType" runat="server" />
</asp:Content>
