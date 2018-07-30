<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OrderSystem.Login" %>

<%@ Register Assembly="DevExpress.Web.Bootstrap.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.Bootstrap" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.v17.2, Version=17.2.8.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html >
<head runat="server">
    <title></title>
    <link href="/Bootstrap/bootstrap.min.css" rel="stylesheet" />
   <link href="/Styles/fontawesome/css/all.css" rel="stylesheet" />
    <style>
        .form-signin {
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }

            .form-signin .form-signin-heading, .form-signin .checkbox {
                margin-bottom: 10px;
            }

            .form-signin .checkbox {
                font-weight: normal;
            }

            .form-signin .form-control {
                position: relative;
                font-size: 16px;
                height: auto;
                padding: 10px;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
            }

                .form-signin .form-control:focus {
                    z-index: 2;
                }

            .form-signin input[type="text"] {
                margin-bottom: -1px;
                border-bottom-left-radius: 0;
                border-bottom-right-radius: 0;
            }

            .form-signin input[type="password"] {
                margin-bottom: 10px;
                border-top-left-radius: 0;
                border-top-right-radius: 0;
            }

        .account-wall {
            margin-top: 20px;
            padding: 40px 0px 20px 0px;
            background-color: #f7f7f7;
            -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
        }

        .login-title {
            color: #555;
            font-size: 18px;
            font-weight: 400;
            display: block;
        }

        .profile-img {
            width: 96px;
            height: 96px;
            margin: 0 auto 10px;
            display: block;
            -moz-border-radius: 50%;
            -webkit-border-radius: 50%;
            border-radius: 50%;
        }

        .need-help {
            margin-top: 10px;
        }

        .new-account {
            display: block;
            margin-top: 10px;
        }

        .formdiv {
            width: 500px;
            margin: auto;
        }
    </style>
    <script>
        function onClick(s, e) {
            callpanel.PerformCallback("LOGIN");
        }
        function OnEndCall(s, e) {
            if (callpanel.cpErr != null) {
                lbMsg.SetText(callpanel.cpErr);
                callpanel.cpErr = null;
            }
            if (callpanel.cpOK != null) {
                callpanel.cpOK = null;
                window.location = "default.aspx";
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 col-md-4 col-md-offset-4">
                    <h1 class="text-center login-title">Sign in</h1>
                    <div class="account-wall">
                        <img class="profile-img" src="images/logo.png" width="120" height="120"
                            alt="">
                        <div class="form-signin">
                            <dx:BootstrapCallbackPanel ID="callpanel" runat="server" ClientInstanceName="callpanel" OnCallback="callpanel_Callback">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <dx:BootstrapTextBox ID="txtUser" ClientInstanceName="txtUser" runat="server" NullText="User ID">
                                        </dx:BootstrapTextBox>
                                        <dx:BootstrapTextBox ID="txtPass" ClientInstanceName="txtPass" runat="server" NullText="Password" Password="True">
                                        </dx:BootstrapTextBox>
                                        <br />
                                        <dx:BootstrapButton ID="BootstrapButton1" runat="server" AutoPostBack="false" Text="Sign In">
                                            <CssClasses Control="btn btn-lg btn-primary btn-block" />
                                            <ClientSideEvents Click="onClick" />
                                        </dx:BootstrapButton>
                                        <dx:ASPxLabel ID="lbMsg" ClientInstanceName="lbMsg" runat="server" Text=""></dx:ASPxLabel>
                                    </dx:ContentControl>
                                </ContentCollection>
                                <ClientSideEvents EndCallback="OnEndCall" />
                            </dx:BootstrapCallbackPanel>                          
                         
                        </div>
                    </div>
                 
                </div>
            </div>
        </div>
    </form>
</body>
</html>
