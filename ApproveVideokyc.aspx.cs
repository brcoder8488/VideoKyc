using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class ApproveVideokyc : System.Web.UI.Page
{
    DataUtility objDUT = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGridviewData();
        }
    }


    private void BindGridviewData()
    {
        DataTable dt = objDUT.GetDataTable("select mm.loginid,(mm.fname +' '+ isnull(mm.lName,''))as memname,mk.FilePath,(case when mk.Status=0 then 'Pending' when mk.Status=1 then 'Confirmed' else 'Reject' end)as status1 from MemberVedio_KYC mk, member_master mm where mk.regno=mm.regno and mk.active=1");
        if (dt.Rows.Count > 0)
        {
            gvDetails.DataSource = dt;
            gvDetails.DataBind();
        }

        dt.Dispose();
    }

    protected void lnkDownload_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
        string relativeFilePath = gvDetails.DataKeys[gvrow.RowIndex].Value.ToString();        
        string filePath = Server.MapPath(relativeFilePath);
        if (File.Exists(filePath))
        {
            Response.Clear();
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("Content-Disposition", "attachment; filename=MWG90182_20231125120354.webm");
            Response.TransmitFile(filePath);
            Response.End();
        }
        else
        {
            Response.Write("File not found");
        }
    }
}