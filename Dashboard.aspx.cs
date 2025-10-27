using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace ITCTRLS_Task
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminLoggedIn"] == null || !(bool)Session["AdminLoggedIn"])
            {
                Response.Redirect("Admin.aspx");
            }

            if (!IsPostBack)
            {
                LoadApplicants();
            }
        }

        private void LoadApplicants()
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT FullName, Age, Education, Languages, FatherName, MobileNumber, Email, MessageBox FROM Applicants";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewApplicants.DataSource = dt;
                GridViewApplicants.DataBind();
            }
        }

        protected void GridViewApplicants_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string email = e.CommandArgument.ToString();

            if (e.CommandName == "Del")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "DELETE FROM Applicants WHERE Email = @Email";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Email", email);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                LoadApplicants(); // Refresh grid after delete
            }

            else if (e.CommandName == "View")
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "SELECT * FROM Applicants WHERE Email = @Email";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Email", email);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        LiteralDetails.Text = $@"
                            <b>Full Name:</b> {dr["FullName"]}<br/>
                            <b>Age:</b> {dr["Age"]}<br/>
                            <b>Education:</b> {dr["Education"]}<br/>
                            <b>Languages:</b> {dr["Languages"]}<br/>
                            <b>Father Name:</b> {dr["FatherName"]}<br/>
                            <b>Mobile Number:</b> {dr["MobileNumber"]}<br/>
                            <b>Email:</b> {dr["Email"]}<br/>
                            <b>Message:</b> {dr["MessageBox"]}";
                        DetailsPanel.Style["display"] = "block";
                    }
                    con.Close();
                }
            }
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Admin.aspx");
        }
    }
}
