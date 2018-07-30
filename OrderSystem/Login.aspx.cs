using OrderSystem.BL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OrderSystem
{
    public partial class Login : System.Web.UI.Page
    {
        DataTable dtUser;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void callpanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split(':');
            if (para[0] == "LOGIN")
            {
                USerLogin();
            }
        }

        void USerLogin()
        {
            string hashedPassword = HashString(txtPass.Text);
            if (CheckLogin(txtUser.Text, hashedPassword))
            {
                callpanel.JSProperties["cpOK"] = 1;
            }

        }

        public static string HashString(string inputString)
        {
            string hashName = "SHA1";
            var algorithm = HashAlgorithm.Create(hashName);
            if (algorithm == null)
                throw new ArgumentException("Unrecognized hash name", hashName);

            byte[] hash = algorithm.ComputeHash(Encoding.UTF8.GetBytes(inputString));
            return Convert.ToBase64String(hash);
        }

        private bool CheckLogin(string UserName, string hashedPassword)
        {

            DataClassesDataContext db = new DataClassesDataContext();
            var user = db.UserAccts.Where(x => x.ID == UserName && x.PWord == hashedPassword && x.Status == "ACTIVE").FirstOrDefault();

            if (user == null)
            {
                callpanel.JSProperties["cpErr"] = "Invalid User ID / Password";
                return false;
            }
            else
            {


                string userdada = user.ID + "|" +
                                 user.Name + "|" +
                                 user.UserType+"|"+
                                 user.PWord.ToString();

                FormsAuthenticationTicket tkt;
                string cookiestr;
                HttpCookie ck;
                tkt = new FormsAuthenticationTicket(1, user.ID,
                                DateTime.Now,
                                DateTime.Now.AddMinutes(30),
                                true, userdada);
                cookiestr = FormsAuthentication.Encrypt(tkt);
                ck = new HttpCookie(FormsAuthentication.FormsCookieName, cookiestr);
                //if (chkPersistCookie.Checked)
                //     ck.Expires = tkt.Expiration;
                ck.Path = FormsAuthentication.FormsCookiePath;
                Response.Cookies.Add(ck);

            }

            return true;
        }
    }
}