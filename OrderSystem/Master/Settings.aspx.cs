using OrderSystem.BL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OrderSystem.Master
{
    public partial class Settings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }

        }

        void LoadData()
        {
            DataClassesDataContext db = new DataClassesDataContext();
            var item = db.OrderSettings.FirstOrDefault();
            if (item == null)
                return;
            DateTime dateTime = new DateTime(item.beforeOrdertime.Value.Ticks);

            txtOrderNum.Value = item.maxorderperday.Value;
            txtTime.Value = dateTime;
        }

        protected void callback_Callback(object source, DevExpress.Web.CallbackEventArgs e)
        {
            string[] para = e.Parameter.Split(':');
            if (para[0] == "SAVE")
            {
                Save();
            }
            else if (para[0] == "CANCEL")
            {
               
            }
        }

        void Save()
        {
            DataClassesDataContext db = new DataClassesDataContext();
            var item = db.OrderSettings.FirstOrDefault();
            if (item == null)
                return;
            try
            {
                
                item.beforeOrdertime = new TimeSpan(txtTime.DateTime.Hour, txtTime.DateTime.Minute, 00);
                item.maxorderperday = Convert.ToInt32(txtOrderNum.Value);
                db.SubmitChanges();
                callback.JSProperties["cpErr"] = "Settings Saved.";
            }
            catch (Exception ex)
            {
                callback.JSProperties["cpErr"] = ex.Message;
            }
        } 
    }
}