<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="OrderSystem.Master.Settings" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .divClass {
          width:800px;
          margin:40px auto;
        }
    </style>
    <script>
        function OnEndCall(s, e) {
            if (callback.cpErr != null) {
                alert(callback.cpErr);
                callback.cpErr = null;
            }
        }
        function OnSaveClick() {
            callback.PerformCallback("SAVE");
        }
         function OnCancelClick() {
           window.location="/Default.aspx"
        }
    </script>
   <div class="divClass">
    <h3>Settings</h3>
    <hr />
    <dx:BootstrapFormLayout ID="BootstrapFormLayout1" runat="server" ShowItemCaptionColon="False" Width="600px" LayoutType="Vertical">
        <SettingsItems HorizontalAlign="Center" />
        <Items>
            <dx:BootstrapLayoutItem Caption="Make Order Before Time">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                       <dx:BootstrapTimeEdit ID="txtTime" runat="server" ClientInstanceName="txtTime">
                        </dx:BootstrapTimeEdit>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
            <dx:BootstrapLayoutItem Caption="Number Of Order Per day">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:BootstrapSpinEdit ID="txtOrderNum" runat="server" ClientInstanceName="txtOrderNum" MaxValue="10" MinValue="1"></dx:BootstrapSpinEdit>
                        
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
            <dx:BootstrapLayoutItem ShowCaption="False">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:BootstrapButton ID="BootstrapFormLayout1_E3" runat="server" Width="120px" Text="Save" AutoPostBack="False">
                            <CssClasses Control="btn-info btn-block"  />
                             <ClientSideEvents Click="OnSaveClick" />
                        </dx:BootstrapButton>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
            <dx:BootstrapLayoutItem ShowCaption="False">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:BootstrapButton ID="BootstrapFormLayout1_E4" runat="server" Width="120px" Text="Cancel" AutoPostBack="False">
                           <CssClasses Control="btn-danger btn-block"  />
                            <ClientSideEvents Click="OnCancelClick" />
                        </dx:BootstrapButton>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:BootstrapLayoutItem>
        </Items>
    </dx:BootstrapFormLayout>
       <dx:ASPxCallback ID="callback" ClientInstanceName="callback" OnCallback="callback_Callback" runat="server">
           <ClientSideEvents EndCallback="OnEndCall" /> 
       </dx:ASPxCallback>
  </div>
</asp:Content>
