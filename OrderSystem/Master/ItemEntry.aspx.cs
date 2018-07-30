using ImageResizer;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Transactions;
using System.Web;
using OrderSystem.BL;

namespace OrderSystem.Master
{
    public partial class ItemEntry : System.Web.UI.Page
    {
        string strID = "";
        string strType = "";


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

        }

        void NewMode()
        {
            txtCategory.Text = "";
            txtICode.Text = "";
            txtImage.Value = null;
            txtImageFilename.Text = "";
            txtName.Text = "";
            txtNameCN.Text = "";
            txtProcess.Text = "";
            txtStatus.Text = "ACTIVE";
            txtType.Text = "";
            txtUOM.Text = "";
            txtIsProcees.Checked = false;
        }

        void EditMode()
        {
            txtICode.ClientEnabled = false;

        }

        void ViewMode()
        {
            txtCategory.ClientEnabled = false;
            txtICode.ClientEnabled = false;
            txtImage.ClientEnabled = false;
            txtImageFilename.ClientEnabled = false;
            txtName.ClientEnabled = false;
            txtNameCN.ClientEnabled = false;
            txtProcess.ClientEnabled = false;
            txtStatus.ClientEnabled = false;
            txtType.ClientEnabled = false;
            txtUOM.ClientEnabled = false;
            btnCancel.ClientVisible = false;
            btnSave.ClientVisible = false;
            txtIsProcees.ClientEnabled = false;
            txtUpload.Visible = false;
        }

        void BindData(string id)
        {
            db = new DataClassesDataContext();
            var item = db.Items.Where(x => x.ItemCode == id).FirstOrDefault();

            if (item == null)
                return;

            txtCategory.Text = item.ItemCategory;
            txtICode.Text = item.ItemCode;
            txtImage.Value = null;
            txtImageFilename.Text = item.imageUrl;
            txtName.Text = item.ItemName;
            txtNameCN.Text = item.ItemNameCN;
            txtProcess.Text = item.ProcessItemCode;
            txtStatus.Text = item.ItemStatus;
            txtType.Text = item.ItemType;
            txtUOM.Text = item.ItemUom;
            txtIsProcees.Checked = item.isProcessItem.Value;
            if (!string.IsNullOrEmpty(item.imageUrl))
            {
                txtImage.ImageUrl = "../ItemImages/" + item.imageUrl;
            }
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


        protected void callpanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            string[] para = e.Parameter.Split(':');
            if (para[0] == "SAVE")
            {
                Save();
            }
        }

        protected void txtUpload_FileUploadComplete(object sender, DevExpress.Web.FileUploadCompleteEventArgs e)
        {
            string counter = DateTime.Now.Ticks.ToString();
            string ext = Path.GetExtension(e.UploadedFile.FileName);
            string replaced_icode = txtICode.Text.ToLower().Replace("\\", "X1").Replace("/", "X2").Replace(":", "X3").Replace("*", "X4").Replace("?", "X5").Replace("\"", "X6").Replace("<", "X7").Replace(">", "X8").Replace("|", "X9");
            replaced_icode = replaced_icode.Replace("`", "Y001").Replace("~", "Y002").Replace("!", "Y1").Replace("@", "Y2").Replace("#", "Y3").Replace("$", "Y4").Replace("%", "Y5").Replace("^", "Y6").Replace("&", "Y7");
            replaced_icode = replaced_icode.Replace("(", "Y9").Replace(")", "Y0").Replace("-", "Z1").Replace("+", "Z2").Replace("_", "Z3").Replace("=", "Z4").Replace("[", "Z5").Replace("]", "Z6").Replace("{", "Z7").Replace("}", "Z8").Replace(";", "Z9").Replace(",", "C1").Replace(".", "C2") + counter;
            string filename = replaced_icode + ext;
            txtImageFilename.Text = filename;
            string strSavePath = "~\\ItemImages\\" + filename;
            ///hdImageName.Text = strSavePath;
            //e.UploadedFile.SaveAs(Server.MapPath(strSavePath));
            string url = ResolveClientUrl(filename);// + "?" + strSavePath + "?" + DateTime.Now.Ticks.ToString();
            e.CallbackData = url;

            foreach (string filekey in HttpContext.Current.Request.Files.Keys)
            {
                HttpPostedFile file = HttpContext.Current.Request.Files[filekey];
                if (file.ContentLength <= 0) continue; //Skip unused file controls.

                ImageJob i = new ImageJob(file, "~\\itemImages\\" + filename,
                    new ImageResizer.ResizeSettings("width=500;height=400;format=png;mode=max"));
                i.CreateParentDirectory = true; //Auto-create the uploads directory.
                i.Build();
                // AddImage(filename, strSavePath);
            }
        }

        void Save()
        {
            db = new DataClassesDataContext();

            var found = db.Items.Where(x => x.ItemCode == txtICode.Text).FirstOrDefault();
            Item item = null;
            if (found == null)
            {
                item = new Item();
                item.CreateBy = hdUserID.Value;
                item.CreateDate = DateTime.Now;
                item.ItemCode = txtICode.Text.ToUpper();

            }
            else
            {
                item = found;
                item.UpdateBy = hdUserID.Value;
                item = found;
                item.UpdateDate = DateTime.Now;
            }
            item.imageUrl = txtImageFilename.Text;
            item.ItemCategory = txtCategory.Text;
            item.ItemName = txtName.Text;
            item.ItemNameCN = txtNameCN.Text;
            item.ItemStatus = txtStatus.Text;
            item.ItemType = txtType.Text;
            item.ItemUom = txtUOM.Text;
            item.ProcessItemCode = txtProcess.Text;
            item.isProcessItem = txtIsProcees.Checked;

            txtImage.ImageUrl = "../ItemImages/" + item.imageUrl;

            if (found == null)
            {
                db.Items.InsertOnSubmit(item);

            }

            using (TransactionScope trans = new TransactionScope())
            {
                try
                {
                    db.SubmitChanges();
                    trans.Complete();
                    callpanel.JSProperties["cpErr"] = "Save sucessfully";
                }
                catch (Exception ex)
                {
                    callpanel.JSProperties["cpErr"] = ex.Message;
                }

            }

        }
    }
}