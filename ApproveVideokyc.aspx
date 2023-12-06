<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ApproveVideokyc.aspx.cs" Inherits="ApproveVideokyc" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>


            <%-- <video width="640" height="360" controls>
                <source src="Videos/MWG90182_20231125120457.webm" type="video/webm">
                Your browser does not support the video tag.
            </video>--%>

            <asp:GridView ID="gvDetails" CssClass="Gridview" runat="server" AutoGenerateColumns="false" DataKeyNames="filepath">
                <HeaderStyle BackColor="#df5015" />
                <Columns>
                
                <asp:BoundField DataField="loginid" HeaderText="Login ID" />
                    <asp:BoundField DataField="memname" HeaderText="Member Name" />
                    <asp:BoundField DataField="status1" HeaderText="Approvel Status" />
                <asp:TemplateField HeaderText="FilePath">
                <ItemTemplate>
                <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" OnClick="lnkDownload_Click"></asp:LinkButton>
                </ItemTemplate>
                </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
