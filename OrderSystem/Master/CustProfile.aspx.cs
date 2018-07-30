using DevExpress.Web.Data;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;
using OrderSystem.BL;


namespace OrderSystem.Master
{
    public partial class CustProfile : System.Web.UI.Page
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
                grid.Columns[0].Visible = false;
                grid.SettingsDataSecurity.AllowDelete = false;
                grid.SettingsDataSecurity.AllowEdit = false;
                grid.SettingsDataSecurity.AllowInsert = false;
                grid.SettingsEditing.Mode = DevExpress.Web.GridViewEditingMode.EditForm;
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

        }

        protected void InsertNewWCItem(OrderedDictionary newValues)
        {
            DataClassesDataContext db = new DataClassesDataContext();
            string custcode = newValues["CustomerCode"].ToString();
            var cust = db.Customers.Where(x => x.CustomerCode == custcode).FirstOrDefault();
            if (cust != null)
            {
                return;
            }
            Customer item = new Customer();
            item.CustomerCode = custcode;
            item.CustomerName = newValues["CustomerName"].ToString();
            item.Reseller = newValues["Reseller"].ToString();
            item.Status = "PENDING";
            item.Status = "PENDING";
            if (newValues["Remarks"] != null)
                item.Remarks = newValues["Remarks"].ToString();
            item.CreateBy = hdUserID.Value;
            item.CreateDate = DateTime.Now;
            db.Customers.InsertOnSubmit(item);
            db.SubmitChanges();
            grid.DataBind();

        }

        protected void DeleteWCItem(OrderedDictionary keys, OrderedDictionary values)
        {
            DataClassesDataContext db = new DataClassesDataContext();
            Int32 id = Convert.ToInt32(keys[0]);
            var cust = db.Customers.Where(x => x.ID == id).FirstOrDefault();
            if (cust == null)
            {
                return;
            }
            db.Customers.DeleteOnSubmit(cust);
            db.SubmitChanges();
            grid.DataBind();
        }

        protected void UpdateWCItem(OrderedDictionary keys, OrderedDictionary newValues)
        {
            DataClassesDataContext db = new DataClassesDataContext();
            Int32 id = Convert.ToInt32(keys[0]);
            var cust = db.Customers.Where(x => x.ID == id).FirstOrDefault();
            if (cust == null)
            {
                return;
            }

            if (newValues["CustomerName"] != null)
                cust.CustomerName = newValues["CustomerName"].ToString();
            if (newValues["Reseller"] != null)
                cust.Reseller = newValues["Reseller"].ToString();
            if (newValues["Remarks"] != null)
                cust.Remarks = newValues["Remarks"].ToString();
            cust.UpdateBy = hdUserID.Value;
            cust.UpdateDate = DateTime.Now;
            db.SubmitChanges();
            grid.DataBind();
        }
    }
}