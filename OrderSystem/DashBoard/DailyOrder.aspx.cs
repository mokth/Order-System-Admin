using OrderSystem.BL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OrderSystem.DashBoard
{
    public partial class DailyOrder : System.Web.UI.Page
    {
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtDateFr.Date = DateTime.Today;
                txtDateTo.Date = DateTime.Today;
            }
            GetData();
            BindGrid();
        }

        void GetData()
        {
            DateTime fr =txtDateFr.Date;
            DateTime to = txtDateTo.Date.AddDays(1);
            // f< x < to
            string sql = string.Format(@"Select * from vDailyOrder where orderDate >='{0}' and OrderDate <'{1}'",fr.ToString("yyyy-MM-dd 00:00:00"), to.ToString("yyyy-MM-dd 00:00:00"));
            dt= BaseADO.GetData(sql);
        }

        void BindGrid()
        {
            grid.DataSource = dt;
            grid.DataBind();

        }

        protected void callpanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split(':');
            if (para[0] == "SEARCH")
            {
                GetData();
                BindGrid();
                callpanel.JSProperties["cpData"] = 1;
            }
        }
    }
}