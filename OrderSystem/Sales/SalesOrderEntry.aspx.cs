using DevExpress.Web.Data;
using OrderSystem.BL;
using System;

using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Transactions;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OrderSystem.Sales
{

    public partial class SalesOrderEntry : System.Web.UI.Page
    {
        string strID = "";
        string strType = "";

        DataTable dt;
        DataClassesDataContext db = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!AuthHelper.CheckAuth())
                    Response.Redirect("~/Login.aspx");
                hdUserID.Value = AuthHelper.UserID;
                hdUserType.Value = AuthHelper.UserType;
            }

            GetQueryString();

            if (!IsPostBack)
            {

                //BindData(strID);

                if (strType == "VIEW")
                {
                    ViewMode();
                }
                else if (strType == "EDIT")
                {
                    EditMode();
                }
                else
                {
                    NewMode();
                }

                BindData(strID);
            }

            BindGrid();
        }

        private void GetQueryString()
        {
            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["ID"] != null)
                    strID = Request.QueryString["ID"].ToString().Replace("'", "''");
                if (Request.QueryString["Type"] != null)
                    strType = Request.QueryString["Type"].ToString().Replace("'", "''");
                else strType = "NEW";
            }
            else strType = "NEW";
        }

        void BindGrid()
        {

            grid.DataSource = dt;
            grid.DataBind();
        }

        void NewMode()
        {
            txtOrderNo.Text = "AUTO";
            txtDate.Date = DateTime.Now;
            txtStatus.Text = "NEW";

        }

        void EditMode()
        {
            txtOrderNo.ClientEnabled = false;

        }

        void ViewMode()
        {
            txtAgent.ClientEnabled = false;
            txtCustCode.ClientEnabled = false;
            txtCustName.ClientEnabled = false;
            txtDate.ClientEnabled = false;
            txtOrderNo.ClientEnabled = false;
            txtRemark.ClientEnabled = false;
            txtStatus.ClientEnabled = false;
            txtType.ClientEnabled = false;
            btnCancel.ClientVisible = false;
            btnSave.ClientVisible = false;
            grid.SettingsDataSecurity.AllowDelete = false;
            grid.SettingsDataSecurity.AllowEdit = false;
            grid.SettingsDataSecurity.AllowInsert = false;
            grid.Columns[0].Visible = false;


        }

        void BindData(string id)
        {
            db = new DataClassesDataContext();
            var found = db.OrderHdrs.Where(x => x.OrderNo == id).FirstOrDefault();

            if (found == null)
                return;

            txtAgent.Text = found.ResellerCode;
            txtCustCode.Text = found.CustomerCode;
            txtCustName.Text = found.CustomerName;
            if (found.OrderDate.HasValue)
                txtDate.Date = found.OrderDate.Value;
            txtOrderNo.Text = found.OrderNo;
            txtRemark.Text = found.Remark;
            txtStatus.Text = found.OrderStatus;
            txtType.Text = found.OrderType;

        }

        void Save()
        {
            db = new DataClassesDataContext();
            if (txtOrderNo.Text == "AUTO")
            {
                txtOrderNo.Text = getSONO();
            }

            string sono = txtOrderNo.Text;
            var order = db.OrderHdrs.Where(x => x.OrderNo == sono).FirstOrDefault();
            OrderHdr hdr = null;
            if (order == null)
            {
                hdr = new OrderHdr();
                hdr.CreateBy = "Admin";
                hdr.CreateDate = DateTime.Now;
                hdr.OrderNo = sono;
                hdr.OrderStatus = txtStatus.Text;
            }
            else
            {
                hdr = order;
            }
            if (txtDate.Date.Year > 2017)
                hdr.OrderDate = txtDate.Date;

            hdr.OrderType = txtType.Text;
            hdr.Remark = txtRemark.Text;
            hdr.ResellerCode = txtAgent.Text;
            hdr.CustomerCode = txtCustCode.Text;
            hdr.CustomerName = txtCustName.Text;

            if (order == null)
            {
                db.OrderHdrs.InsertOnSubmit(hdr);

            }

            using (TransactionScope trans = new TransactionScope())
            {
                try
                {
                    db.SubmitChanges();
                    trans.Complete();
                    callback.JSProperties["cpErr"] = "Save sucessfully";
                }
                catch (Exception ex)
                {
                    callback.JSProperties["cpErr"] = ex.Message;
                }

            }

        }

        string getSONO()
        {
            DateTime date = txtDate.Date;
            return GenerateAutoNumberWithDate("SO", date.Year, date.Month);
        }

        public string GenerateAutoNumberWithDate(String prefix, int year, int month)
        {
            string predelimeter = "/";

            string result = "";
            var runnum = db.NumberRunNOs.Where(x => x.NumCd == "SO" && x.Year == year && x.Month == month).FirstOrDefault();
            if (runnum == null)
            {
                runnum = new NumberRunNO();
                runnum.Created = DateTime.Now;
                runnum.Month = Convert.ToInt16(month);
                runnum.NumCd = "SO";
                runnum.NumDes = "SALE ORDRER";
                runnum.Prefix = "SO";
                runnum.Seq = 1;
                runnum.TotLength = 7;
                runnum.Year = Convert.ToInt16(year);
                db.NumberRunNOs.InsertOnSubmit(runnum);
            }
            else
            {
                runnum.Seq = runnum.Seq + 1;
            }

            result = runnum.Prefix + year.ToString().Substring(2, 2) + month.ToString().PadLeft(2, '0') + predelimeter + runnum.Seq.ToString().PadLeft(Convert.ToInt32(runnum.TotLength), '0');


            return result;
        }

        protected void grid_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
        {
            string[] para = e.Parameters.Split(':');
            if (para[0] == "ADDNEW")
            {
                grid.JSProperties["cpNew"] = 1;
            }
        }

        protected void grid_BatchUpdate(object sender, DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs e)
        {
            foreach (var args in e.InsertValues)
                InsertNewWCItem(args.NewValues);

            foreach (var args in e.UpdateValues)
                UpdateWCItem(args.Keys, args.NewValues);

            foreach (var args in e.DeleteValues)
                DeleteWCItem(args.Keys, args.Values);

            e.Handled = true;
        }

        protected void grid_RowUpdating(object sender, DevExpress.Web.Data.ASPxDataUpdatingEventArgs e)
        {
            UpdateWCItem(e.Keys, e.NewValues);
            CancelWCEditing(e);
        }

        protected void grid_RowInserting(object sender, DevExpress.Web.Data.ASPxDataInsertingEventArgs e)
        {
            InsertNewWCItem(e.NewValues);
            CancelWCEditing(e);
        }

        protected void grid_RowDeleting(object sender, ASPxDataDeletingEventArgs e)
        {
            DeleteWCItem(e.Keys, e.Values);
            CancelWCEditing(e);
        }

        protected void CancelWCEditing(CancelEventArgs e)
        {
            e.Cancel = true;
            grid.CancelEdit();
        }

        protected void grid_InitNewRow(object sender, DevExpress.Web.Data.ASPxDataInitNewRowEventArgs e)
        {
            DataClassesDataContext db = new DataClassesDataContext();
            int lineno = 1;
            var line = db.OrderDtls.Max(x => x.OrderLine);
            if (line != null)
            {
                lineno = Convert.ToInt32(line);
            }
            e.NewValues["OrderLine"] = lineno;
        }

        protected void InsertNewWCItem(OrderedDictionary newValues)
        {
            DataClassesDataContext db = new DataClassesDataContext();
            string code = newValues["ItemCode"].ToString();
            int orderline = Convert.ToInt32(newValues["OrderLine"]);
            var cust = db.OrderDtls.Where(x => x.OrderLine == orderline && x.OrderNo == txtOrderNo.Text).FirstOrDefault();
            if (cust != null)
            {
                return;
            }
            OrderDtl item = new OrderDtl();
            int lineno = 1;
            var line = db.OrderDtls.Max(x => x.OrderLine);
            if (line != null)
            {
                lineno = Convert.ToInt32(line);
            }
            item.OrderNo = txtOrderNo.Text;
            item.OrderLine = lineno;
            item.ItemCode = code;
            item.ItemName = newValues["ItemName"].ToString();
            item.ItemUom = newValues["ItemUom"].ToString();
            item.Quantity = Convert.ToDecimal(newValues["Quantity"]);
            if (newValues["Remark"] != null)
                item.Remark = newValues["Remark"].ToString();


            db.OrderDtls.InsertOnSubmit(item);
            db.SubmitChanges();
            grid.DataBind();

        }

        protected void DeleteWCItem(OrderedDictionary keys, OrderedDictionary values)
        {
            DataClassesDataContext db = new DataClassesDataContext();
            Int32 id = Convert.ToInt32(keys[0]);
            var cust = db.OrderDtls.Where(x => x.ID == id).FirstOrDefault();
            if (cust == null)
            {
                return;
            }
            db.OrderDtls.DeleteOnSubmit(cust);
            db.SubmitChanges();
            grid.DataBind();
        }

        protected void UpdateWCItem(OrderedDictionary keys, OrderedDictionary newValues)
        {
            DataClassesDataContext db = new DataClassesDataContext();
            Int32 id = Convert.ToInt32(keys[0]);
            var item = db.OrderDtls.Where(x => x.ID == id).FirstOrDefault();
            if (item == null)
            {
                return;
            }
            if (newValues["Quantity"] != null)
                item.Quantity = Convert.ToDecimal(newValues["Quantity"]);
            if (newValues["Remark"] != null)
                item.Remark = newValues["Remark"].ToString();

            db.SubmitChanges();
            grid.DataBind();
        }

        protected void callback_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split(':');
            if (para[0] == "SAVE")
            {
                Save();
            }
        }


    }
}