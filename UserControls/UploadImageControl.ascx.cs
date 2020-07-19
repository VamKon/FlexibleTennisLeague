using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using Telerik.Web.UI;
using System.IO;
using System.Data.Linq;
using System.Web.Configuration;
using DLL;

namespace FlexibleTennisLeague.UserControls
{
    public partial class UploadImageControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                Response.Redirect(WebConfigurationManager.AppSettings["LoginPageURL"].ToString());
        }
        protected void uploadButton_Click(object sender, EventArgs e)
        {
            if (RadUpload1.UploadedFiles.Count > 0)
            {
                string target = Server.MapPath("~/ProfileImages");
                System.Drawing.Image.GetThumbnailImageAbort thumbnailImageAbortDelegate =
                  new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback);
                Guid fileName = Guid.NewGuid();
                foreach (UploadedFile file in RadUpload1.UploadedFiles)
                {
                    file.SaveAs(string.Format("{0}//{1}", target, file.GetName()));
                    using (Bitmap originalImage = new Bitmap(file.InputStream))
                    {
                        //You can implement additional logic to compute
                        // the width / height according your requirements
                        //int width = originalImage.Width / 2;
                        double ratio = Convert.ToDouble(originalImage.Width) / Convert.ToDouble(originalImage.Height);
                        int width = 160;
                        int height = Convert.ToInt32(160 * (1 / ratio));
                        if (height > 160)
                        {
                            height = 160;
                            width = Convert.ToInt32(160 * ratio);
                        }

                        System.Drawing.Image thumbnail = new Bitmap(width, height);
                        using (Graphics g = Graphics.FromImage(thumbnail))
                        {
                            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                            g.FillRectangle(Brushes.White, 0, 0, width, height);
                            g.DrawImage(originalImage, 0, 0, width, height);
                            string thumbnailFileName = string.Format("{0}//{1}.jpg", target, fileName.ToString());
                            thumbnail.Save(thumbnailFileName);
                        }

                    }

                    //Delete original Image
                    try
                    {
                        if (File.Exists(string.Format("{0}//{1}", target, file.GetName())))
                            File.Delete(string.Format("{0}//{1}", target, file.GetName()));
                    }
                    catch
                    {
                    }

                    using (FlexibleTennisLeagueDataContext dataContext = new FlexibleTennisLeagueDataContext())
                    {
                        ISingleResult<SelectUserByEmailIdResult> users = dataContext.SelectUserByEmailId(HttpContext.Current.User.Identity.Name);
                        foreach (SelectUserByEmailIdResult result in users)
                        {
                            if (result.ProfileImageName.HasValue)
                            {
                                try
                                {
                                    if (File.Exists(string.Format("{0}//{1}.jpg", target, result.ProfileImageName)))
                                        File.Delete(string.Format("{0}//{1}.jpg", target, result.ProfileImageName));
                                }
                                catch (IOException)
                                {
                                }
                            }

                        }
                        dataContext.UpdateUserProfileImage(HttpContext.Current.User.Identity.Name, fileName);
                        InjectScript.Text = "<script>RefreshParentPage();CloseOnReload()</" + "script>";
                    }
                }
            }
            else if (RadUpload1.InvalidFiles.Count > 0)
            {
                if (RadUpload1.InvalidFiles[0].ContentLength > 4)
                {
                    errorLabel.Text = "Image file size should be less than 4 MB.";
                }
            }
            else
            {
                errorLabel.Text = "Please select a valid image";
            }

        }

        public bool ThumbnailCallback()
        {
            return false;
        }
    }
}