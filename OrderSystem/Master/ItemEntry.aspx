<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="ItemEntry.aspx.cs" Inherits="OrderSystem.Master.ItemEntry" %>
<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script>
        function OnFileUploadCompleted(s, e) {
            console.log(e.callbackData);
            // "~\\ItemImages\\" + filename;
            var imgurl = '../ItemImages/' + e.callbackData;
            txtImageFilename.SetText(e.callbackData);
            txtImage.SetImageUrl(imgurl);
        }
        function OnSaveClick(s, e) {
            if (ASPxClientEdit.ValidateGroup('vgSave')) {
                callpanel.PerformCallback("SAVE");
            }
        }
        function OnCancelClick(s, e) {
            window.location = "ItemProfile.aspx";
        }
          function onCallPanelEndCall(s, e) {
             if (callpanel.cpErr != null) {
                 alert(callpanel.cpErr);
                 callpanel.cpErr = null;
             }
         }
    </script>
    <dx:BootstrapCallbackPanel ID="callpanel" runat="server" ClientInstanceName="callpanel" OnCallback="callpanel_Callback">
        <ContentCollection>
            <dx:ContentControl runat="server">
                <dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" ShowItemCaptionColon="False">
                    <SettingsItemCaptions HorizontalAlign="Left" />
                    <SettingsItems HorizontalAlign="Left" />
                    <Items>
                        <dx:BootstrapLayoutItem Caption="ITEM CODE">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapTextBox ID="txtICode" ClientInstanceName="txtICode" runat="server">
                                        <ValidationSettings ValidationGroup="vgSave">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:BootstrapTextBox>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                        <dx:BootstrapLayoutItem Caption="STATUS">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapComboBox ID="txtStatus" ClientInstanceName="txtStatus" runat="server">
                                        <Items>
                                            <dx:BootstrapListEditItem Text="ACTIVE" Value="ACTIVE">
                                            </dx:BootstrapListEditItem>
                                            <dx:BootstrapListEditItem Text="PENDING" Value="PENDING">
                                            </dx:BootstrapListEditItem>
                                        </Items>
                                         <ValidationSettings ValidationGroup="vgSave">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:BootstrapComboBox>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                        <dx:BootstrapLayoutItem Caption="IMAGE" BeginRow="True">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapImage ID="txtImage" ClientInstanceName="txtImage" runat="server" Height="300px" Width="300px"></dx:BootstrapImage>
                                    <dx:BootstrapUploadControl ID="txtUpload" runat="server" ShowUploadButton="True" OnFileUploadComplete="txtUpload_FileUploadComplete">
                                        <ClientSideEvents FileUploadComplete="OnFileUploadCompleted" />
                                    </dx:BootstrapUploadControl>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                        <dx:BootstrapLayoutItem Caption="ITEM NAME">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapMemo ID="txtName" ClientInstanceName="txtName" runat="server">
                                         <ValidationSettings ValidationGroup="vgSave">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:BootstrapMemo>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                        <dx:BootstrapLayoutItem Caption="ITEM NAME">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapMemo ID="txtNameCN" ClientInstanceName="txtNameCN" runat="server">
                                         <ValidationSettings ValidationGroup="vgSave">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                    </dx:BootstrapMemo>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                        <dx:BootstrapLayoutItem Caption="CATEGORY">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapComboBox ID="txtCategory" ClientInstanceName="txtCategory" runat="server" DataSourceID="SqlDataSourceCat" TextField="Code" ValueField="Code">
                                  <ValidationSettings ValidationGroup="vgSave">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                        </dx:BootstrapComboBox>
                                    <asp:SqlDataSource ID="SqlDataSourceCat" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Code] FROM [ItemCategory]"></asp:SqlDataSource>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>

                        <dx:BootstrapLayoutItem Caption="UOM">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapComboBox ID="txtUOM" ClientInstanceName="txtUOM" runat="server" DataSourceID="SqlDataSourceUOM" TextField="Code" ValueField="Code">
                                        <ValidationSettings ValidationGroup="vgSave">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                        </dx:BootstrapComboBox>
                                    <asp:SqlDataSource ID="SqlDataSourceUOM" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Code] FROM [ItemUOM]"></asp:SqlDataSource>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                        <dx:BootstrapLayoutItem Caption="ITEM TYPE">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapComboBox ID="txtType" ClientInstanceName="txtType" runat="server" DataSourceID="SqlDataSourceType" TextField="Code" ValueField="Code">
                                        <ValidationSettings ValidationGroup="vgSave">
                                            <RequiredField IsRequired="True" />
                                        </ValidationSettings>
                                        </dx:BootstrapComboBox>
                                    <asp:SqlDataSource ID="SqlDataSourceType" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Code] FROM [ItemType]"></asp:SqlDataSource>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                        <dx:BootstrapLayoutItem Caption="PROCESS ITEM">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapComboBox ID="txtProcess" ClientInstanceName="txtProcess" runat="server" DataSourceID="SqlDataSourceProcess" TextField="ItemCode" ValueField="ItemCode">
                                    </dx:BootstrapComboBox>
                                    <asp:SqlDataSource ID="SqlDataSourceProcess" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [ItemCode] FROM [Item]"></asp:SqlDataSource>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                         <dx:BootstrapLayoutItem Caption="IS PROCESS ITEM">
                            <ContentCollection>
                                <dx:ContentControl runat="server">
                                    <dx:BootstrapCheckBox ID="txtIsProcees" ClientInstanceName="txtIsProcees" runat="server"></dx:BootstrapCheckBox>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:BootstrapLayoutItem>
                    </Items>
                </dx:BootstrapFormLayout>
                <dx:BootstrapTextBox ID="txtImageFilename" runat="server" ClientInstanceName="txtImageFilename" ClientVisible="False"></dx:BootstrapTextBox>
            </dx:ContentControl>
        </ContentCollection>
         <ClientSideEvents EndCallback="onCallPanelEndCall" />
    </dx:BootstrapCallbackPanel>
    

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
     <asp:HiddenField ID="hdUserID" runat="server" />
      <asp:HiddenField ID="hdUserType" runat="server" />
</asp:Content>

