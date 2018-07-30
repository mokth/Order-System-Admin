using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Security;

/// <summary>
/// Summary description for AuthHelper
/// </summary>
public class AuthHelper
{
    static string _userid;
    static string _usertype;

    public static string UserID { get {return _userid; } }
    public static string UserType { get { return _usertype; } }

    public static bool CheckAuth()
    {
        bool isValid = false;
        _userid = "";
        _usertype = "";

        HttpCookie authCookie = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];
        if (authCookie != null)
        {
            FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
            
            string[] para = ticket.UserData.Split(new char[] { '|' });
            if (para.Length > 2)
            {
                if (!ticket.Expired)
                {
                    isValid = true;
                    _userid = para[0];
                    _usertype = para[2];
                }
            }
            //isValid = !ticket.Expired;
        }
     
        return isValid;
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
}