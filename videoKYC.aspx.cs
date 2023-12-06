using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class videoKYC : System.Web.UI.Page
{
    DataUtility objDUT = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["MaxReg"] != null && Session["loginid"] != null)
        {            
            if (Request.Files.Count > 0 )
            {
                string dbfilepath = "",playpath="";               
                string fileName = String.Format(Session["loginid"]+".webm");
                var file = Request.Files[0];
                if (file != null && file.ContentLength > 0)
                {
                    var uploadPath = Server.MapPath("~/Videos/");
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }

                    var filePath = Path.Combine(uploadPath, fileName);
                    file.SaveAs(filePath);

                    // save path to database
                    dbfilepath = "~/Videos/" + fileName.ToString();
                    playpath = "https://mywaygrowth.in.net/Videos/" + fileName.ToString();

                    int count = 0;
                    count = Convert.ToInt32(objDUT.GetScalar("select count(*) from MemberVedio_KYC where regno=" + Convert.ToInt32(Session["MaxReg"].ToString()) + "").ToString());
                    if (count == 0)
                    {
                        int _result = objDUT.ExecuteSql("insert into MemberVedio_KYC (RegNo,FilePath,KycDate,Status,Active,FilePath_Play) values (" + Convert.ToInt64(Session["MaxReg"].ToString()) + ",'" + dbfilepath + "',getdate(),0,1,'" + playpath + "')");
                    }
                    else
                    {
                        int _result = objDUT.ExecuteSql("update MemberVedio_KYC set KycDate = getdate(),status=0 where regno=" + Convert.ToInt32(Session["MaxReg"].ToString()) + "");
                    }
                }                              
            }
        }
        else
        {
            tbl.Visible = false;
            lblmsg.Text = "Session expired Please closed window and login again..";
        }       
    }
}