using System;
using System.Configuration;
using System.Data.SqlClient;

namespace ITCTRLS_Task
{
    public partial class LoginPage : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

        protected void BT_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM User_Registration WHERE Name=@Name AND Password=@Password";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", UN.Text.Trim());
                        cmd.Parameters.AddWithValue("@Password", PD.Text.Trim());

                        con.Open();
                        int count = Convert.ToInt32(cmd.ExecuteScalar());
                        con.Close();

                        if (count > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                                "alert('Login Successful!'); window.location='Application.aspx';", true);
                        }
                        else
                        {
                            Msg.Text = "Invalid Username or Password!";
                            Msg.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Msg.Text = "Error: " + ex.Message;
                Msg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            
            Response.Redirect("User_Registertion.aspx"); 
        }
    }
}
