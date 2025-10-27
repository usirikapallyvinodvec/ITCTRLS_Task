using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ITCTRLS_Task
{
    public partial class Admin : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e) { }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string adminName = TxtAdminName.Text.Trim();
            string password = TxtPassword.Text.Trim();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM User_Registration WHERE Name=@AdminName AND password=@Password";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@AdminName", adminName);
                cmd.Parameters.AddWithValue("@Password", password);

                con.Open();
                int count = (int)cmd.ExecuteScalar();
                con.Close();

                if (count > 0)
                {
                  
                    Session["AdminLoggedIn"] = true;
                    Session["AdminName"] = adminName;
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    MsgLabel.ForeColor = System.Drawing.Color.Red;
                    MsgLabel.Text = "Invalid Admin Name or Password!";
                }
            }
        }
    }
}
