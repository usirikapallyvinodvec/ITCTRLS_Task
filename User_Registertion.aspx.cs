using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;

namespace ITCTRLS_Task
{
    public partial class User_Registration : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

        public void ClearFields()
        {
            txtname.Text = string.Empty;
            txtpassword.Text = string.Empty;
            txtconfirmpassword.Text = string.Empty;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClearFields();
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
          
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string query = "SELECT COUNT(*) FROM User_Registration WHERE Name = @Name";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("Name", txtname.Text.Trim());
                    int Count = (int)cmd.ExecuteScalar();
                    if (Count > 0)
                    {

                        ClientScript.RegisterStartupScript(this.GetType(), "exists",
                            "alert('User already exists! Please choose another username.');", true);
                        return;
                    }
                    if (Count > 0)
                    {

                        ClientScript.RegisterStartupScript(this.GetType(), "exists",
                            "alert('User already exists! Please choose another username.');", true);
                        return;
                    }
                }
                string insertQuery = @"INSERT INTO User_Registration (Name, Password, ConfirmPassword)
                                           VALUES (@Name, @Password, @ConfirmPassword)";
                using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                {
                    insertCmd.Parameters.AddWithValue("@Name", txtname.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@Password", txtpassword.Text.Trim());
                    insertCmd.Parameters.AddWithValue("@ConfirmPassword", txtconfirmpassword.Text.Trim());

                    insertCmd.ExecuteNonQuery();
                }

                conn.Close();

               
                string script = "alert('Registered Successfully! Redirecting to login page...');" +
                    " window.location='LoginPage.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
            }
        }
    }
         
}
