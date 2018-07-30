using OrderSystem.BL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace OrderSystem.Sales
{

    public partial class SalesOrderList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!AuthHelper.CheckAuth())
                    Response.Redirect("~/Login.aspx");
                hdUserID.Value = AuthHelper.UserID;
                hdUserType.Value = AuthHelper.UserType;
                SetAccess();
            }
        }

        void SetAccess()
        {
            if (hdUserType.Value.ToLower() != "admin")
            {
                btnNew.ClientVisible = false;
                grid.Columns[0].Visible = false;
                grid.SettingsDataSecurity.AllowDelete = false;
                grid.SettingsDataSecurity.AllowEdit = false;
                grid.SettingsDataSecurity.AllowInsert = false;
                grid.SettingsEditing.Mode = DevExpress.Web.GridViewEditingMode.EditForm;
            }

        }

        protected void grid_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            string[] para = e.Parameters.Split(':');
            if (para[0] == "NEW")
            {
            }
            else if (para[0] == "EDIT")
            {
                Edit(para[1]);
            }
            else if (para[0] == "VIEW")
            {
                View(para[1]);
            }
            else if (para[0] == "DELETE")
            {
            }
        }

        void Edit(string key)
        {
            int id = Convert.ToInt32(key);
            DataClassesDataContext db = new DataClassesDataContext();
            var hdr = db.OrderHdrs.Where(x => x.ID == id).FirstOrDefault();
            if (hdr == null)
                return;

            grid.JSProperties["cpUrl"] = "ID=" + hdr.OrderNo + "&Type=EDIT";
        }
        void View(string key)
        {
            int id = Convert.ToInt32(key);
            DataClassesDataContext db = new DataClassesDataContext();
            var hdr = db.OrderHdrs.Where(x => x.ID == id).FirstOrDefault();
            if (hdr == null)
                return;

            grid.JSProperties["cpUrlView"] = "ID=" + hdr.OrderNo + "&Type=VIEW";
        }
    }
}