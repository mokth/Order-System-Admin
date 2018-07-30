using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OrderSystem.DashBoard
{
    public partial class OrderPivot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!AuthHelper.CheckAuth())
                    Response.Redirect("~/Login.aspx");
          
            }

        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            ASPxPivotGridExporter1.ExportXlsxToResponse("OrderPivot.xlsx");
        }
    }
}