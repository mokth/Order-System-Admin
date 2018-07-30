using DevExpress.Web.Data;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;
using OrderSystem.BL;

namespace OrderSystem.Master
{
    public partial class ItemUOMProfile : System.Web.UI.Page
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
            string code = newValues["Code"].ToString();
            var cust = db.ItemUOMs.Where(x => x.Code == code).FirstOrDefault();
            if (cust != null)
            {
                return;
            }
            ItemUOM item = new ItemUOM();
            item.Code = code;
            item.Description = newValues["Description"].ToString();
            item.CreateBy = hdUserID.Value;
            item.CreateDate = DateTime.Now;
            db.ItemUOMs.InsertOnSubmit(item);
            db.SubmitChanges();
            grid.DataBind();

        }

        protected void DeleteWCItem(OrderedDictionary keys, OrderedDictionary values)
        {
            DataClassesDataContext db = new DataClassesDataContext();

            var cust = db.ItemUOMs.Where(x => x.Code == keys[0].ToString()).FirstOrDefault();
            if (cust == null)
            {
                return;
            }
            db.ItemUOMs.DeleteOnSubmit(cust);
            db.SubmitChanges();
            grid.DataBind();
        }

        protected void UpdateWCItem(OrderedDictionary keys, OrderedDictionary newValues)
        {
            DataClassesDataContext db = new DataClassesDataContext();
            var cust = db.ItemUOMs.Where(x => x.Code == keys[0].ToString()).FirstOrDefault();
            if (cust == null)
            {
                return;
            }

            if (newValues["Description"] != null)
                cust.Description = newValues["Description"].ToString();
            cust.UpdateBy = hdUserID.Value;
            cust.UpdateDate = DateTime.Now;
            db.SubmitChanges();
            grid.DataBind();
        }
    }
}