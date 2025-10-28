using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace ITCTRLS_Task
{
    public partial class Dashboard : System.Web.UI.Page
    {
        private readonly string connStr = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

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
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"SELECT FullName, Age, Education, Languages, FatherName, 
                                     MobileNumber, Email, PhotoPath, MessageBox FROM Applicants";
                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridViewApplicants.DataSource = dt;
                    GridViewApplicants.DataBind();
                }
            }
            catch (Exception ex)
            {
               
                ClientScript.RegisterStartupScript(this.GetType(), "error",
                    $"alert('Error loading applicants: {ex.Message}');", true);
            }
        }

        protected void GridViewApplicants_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string email = e.CommandArgument.ToString();

            switch (e.CommandName)
            {
                case "Del":
                    DeleteApplicant(email);
                    break;

                case "View":
                    ViewApplicant(email);
                    break;

                case "EditRow":
                    EditApplicant(email);
                    break;
            }
        }

        private void DeleteApplicant(string email)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = "DELETE FROM Applicants WHERE Email = @Email";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Email", email);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadApplicants();
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Record deleted successfully!');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error",
                    $"alert('Error deleting record: {ex.Message}');", true);
            }
        }

        private void ViewApplicant(string email)
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
                    string photoPath = dr["PhotoPath"].ToString();
                    string fullPhotoUrl = ResolveUrl($"~/Uploads/{photoPath}");

                    string imgHtml = !string.IsNullOrEmpty(photoPath)
                        ? $"<img src='{fullPhotoUrl}' class='app-photo' alt='Applicant Photo' /><br/>"
                        : "<b>Photo Not Available</b><br/>";

                    LiteralDetails.Text = $@"
                        {imgHtml}
                        <b>Full Name:</b> {dr["FullName"]}<br/>
                        <b>Age:</b> {dr["Age"]}<br/>
                        <b>Education:</b> {dr["Education"]}<br/>
                        <b>Languages:</b> {dr["Languages"]}<br/>
                        <b>Father Name:</b> {dr["FatherName"]}<br/>
                        <b>Mobile Number:</b> {dr["MobileNumber"]}<br/>
                        <b>Email:</b> {dr["Email"]}<br/>
                        <b>Message:</b> {dr["MessageBox"]}";

                    DetailsPanel.Style["display"] = "block";
                    EditPanel.Style["display"] = "none";
                }
            }
        }

        private void EditApplicant(string email)
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
                    HiddenEmail.Value = dr["Email"].ToString();
                    txtFullName.Text = dr["FullName"].ToString();
                    txtAge.Text = dr["Age"].ToString();
                    txtEducation.Text = dr["Education"].ToString();
                    txtLanguages.Text = dr["Languages"].ToString();
                    txtFatherName.Text = dr["FatherName"].ToString();
                    txtMobileNumber.Text = dr["MobileNumber"].ToString();
                    txtEmail.Text = dr["Email"].ToString();
                    txtMessage.Text = dr["MessageBox"].ToString();

                    EditPanel.Style["display"] = "block";
                    DetailsPanel.Style["display"] = "none";
                }
            }
        }

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"UPDATE Applicants SET 
                                        FullName = @FullName, 
                                        Age = @Age, 
                                        Education = @Education, 
                                        Languages = @Languages, 
                                        FatherName = @FatherName, 
                                        MobileNumber = @MobileNumber, 
                                        MessageBox = @Message,
                                        Email = @NewEmail
                                     WHERE Email = @Email";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Age", txtAge.Text.Trim());
                    cmd.Parameters.AddWithValue("@Education", txtEducation.Text.Trim());
                    cmd.Parameters.AddWithValue("@Languages", txtLanguages.Text.Trim());
                    cmd.Parameters.AddWithValue("@FatherName", txtFatherName.Text.Trim());
                    cmd.Parameters.AddWithValue("@MobileNumber", txtMobileNumber.Text.Trim());
                    cmd.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                    cmd.Parameters.AddWithValue("@NewEmail", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", HiddenEmail.Value);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadApplicants();
                EditPanel.Style["display"] = "none";

                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Record updated successfully!');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "error",
                    $"alert('Error updating record: {ex.Message}');", true);
            }
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Admin.aspx");
        }
    }
}
