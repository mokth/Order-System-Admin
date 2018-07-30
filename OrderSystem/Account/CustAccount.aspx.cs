using DevExpress.Web.Data;
using OrderSystem.BL;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OrderSystem.Account
{
    public partial class CustAccount : System.Web.UI.Page
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
            if (hdUserType.Value.ToLower()!="admin")
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
            e.NewValues["CreateBy"] =  hdUserID.Value;
            e.NewValues["CreateDate"] =DateTime.Now;
        }

        protected void InsertNewWCItem(OrderedDictionary newValues)
        {
            DataClassesDataContext db = new DataClassesDataContext();
            string code = newValues["ID"].ToString();
            var cust = db.CustAccts.Where(x => x.ID == code).FirstOrDefault();
            if (cust != null)
            {
                return;
            }
            string hash = AuthHelper.HashString(newValues["PWord"].ToString());
            CustAcct item = new CustAcct();
            item.ID = newValues["ID"].ToString();
            item.Name = newValues["Name"].ToString();
            item.CustomerCode = newValues["CustomerCode"].ToString();
            item.PWord = hash;
            item.Status = newValues["Status"].ToString();
            item.UserType = newValues["UserType"].ToString();
            item.CreateBy = hdUserID.Value;
            item.CreateDate = DateTime.Now;
            item.chgpass = true;
            db.CustAccts.InsertOnSubmit(item);
            db.SubmitChanges();
            grid.DataBind();

        }

        protected void DeleteWCItem(OrderedDictionary keys, OrderedDictionary values)
        {
            DataClassesDataContext db = new DataClassesDataContext();
         
            var cust = db.CustAccts.Where(x =>x.ID== keys[0].ToString()).FirstOrDefault();
            if (cust == null)
            {
                return;
            }
            db.CustAccts.DeleteOnSubmit(cust);
            db.SubmitChanges();
            grid.DataBind();
        }

        protected void UpdateWCItem(OrderedDictionary keys, OrderedDictionary newValues)
        {
            DataClassesDataContext db = new DataClassesDataContext();
            var cust = db.CustAccts.Where(x => x.ID == keys[0].ToString()).FirstOrDefault();
            if (cust == null)
            {
                return;
            }

            if (newValues["PWord"] != null)
            {
                string hash = AuthHelper.HashString(newValues["PWord"].ToString());
                cust.PWord = hash;
                cust.chgpass = true;
            }

            if (newValues["Name"] != null)
                cust.Name = newValues["Name"].ToString();

            if (newValues["CustomerCode"] != null)
                cust.CustomerCode = newValues["CustomerCode"].ToString();


            if (newValues["Status"] != null)
                cust.Status = newValues["Status"].ToString();

            if (newValues["UserType"] != null)
                cust.UserType = newValues["UserType"].ToString();

            cust.UpdateBy = hdUserID.Value;
            cust.UpdateDate= DateTime.Now;
           

            db.SubmitChanges();
            grid.DataBind();
        }
    }
}