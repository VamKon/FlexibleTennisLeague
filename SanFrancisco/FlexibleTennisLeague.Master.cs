using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FlexibleTennisLeague.SanFrancisco
{
    public partial class FlexibleTennisLeague : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected override void Render(System.Web.UI.HtmlTextWriter writer) 
        {
            if (!Request.Url.AbsolutePath.Contains("Users"))
            {
                System.IO.StringWriter stringWriter = new System.IO.StringWriter();
                HtmlTextWriter htmlWriter = new HtmlTextWriter(stringWriter);
                base.Render(htmlWriter);
                string html = stringWriter.ToString();
                int StartPoint = html.IndexOf("<input type=\"hidden\" name=\"__VIEWSTATE\"");
                if (StartPoint >= 0)
                {
                    int EndPoint = html.IndexOf("/>", StartPoint) + 2;
                    string viewstateInput = html.Substring(StartPoint, EndPoint - StartPoint);
                    html = html.Remove(StartPoint, EndPoint - StartPoint);
                    int FormEndStart = html.IndexOf("</form>") - 1;
                    if (FormEndStart >= 0)
                    {
                        html = html.Insert(FormEndStart, viewstateInput);
                    }
                }
                writer.Write(html);
            }
            else
                base.Render(writer);
        }
    }
}
