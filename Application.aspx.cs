using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ITCTRLS_Task
{
    public partial class Application : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

      
        public void ClearFields()
        {
            TxtBox.Text = string.Empty;
            NAge.Text = string.Empty;
            EBox.Text = string.Empty;
            CheckBox.ClearSelection();
            TxtFname.Text = string.Empty;
            MNumbetrt.Text = string.Empty;
            EmailTxt.Text = string.Empty;
            TxtMessage.Text = string.Empty;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClearFields();
            }
        }

        protected void Button_Click(object sender, EventArgs e)
        {

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Applicants 
                                (FullName, Age, Education, Languages, FatherName, MobileNumber, Email, MessageBox) 
                                VALUES (@FullName, @Age, @Education, @Languages, @FatherName, @MobileNumber, @Email, @MessageBox)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FullName", TxtBox.Text.Trim());
                    cmd.Parameters.AddWithValue("@Age", NAge.Text.Trim());
                    cmd.Parameters.AddWithValue("@Education", EBox.Text.Trim());
                    cmd.Parameters.AddWithValue("@Languages", GetSelectedLanguages());
                    cmd.Parameters.AddWithValue("@FatherName", TxtFname.Text.Trim());
                    cmd.Parameters.AddWithValue("@MobileNumber", MNumbetrt.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", EmailTxt.Text.Trim());
                    cmd.Parameters.AddWithValue("@MessageBox", TxtMessage.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

          
            try
            {
                SendMail(EmailTxt.Text.Trim(), TxtBox.Text.Trim(), TxtMessage.Text.Trim());
                string successScript = "alert('Application submitted successfully! Email sent to your address.');";
                ClientScript.RegisterStartupScript(this.GetType(), "success", successScript, true);
            }
            catch (Exception ex)
            {
                string failScript = $"alert('Application saved, but email sending failed: {ex.Message}');";
                ClientScript.RegisterStartupScript(this.GetType(), "fail", failScript, true);
            }

            
            ClearFields();
        }

     
        private string GetSelectedLanguages()
        {
            string languages = "";
            foreach (ListItem item in CheckBox.Items)
            {
                if (item.Selected)
                {
                    if (!string.IsNullOrEmpty(languages))
                        languages += ", ";
                    languages += item.Text;
                }
            }
            return languages;
        }

        // Send email using Gmail SMTP with App Password
        private void SendMail(string toEmail, string fullName, string messageContent)
        {
            string fromEmail = "usirikapallyvinod8465@gmail.com";
            string appPassword = "rmokdmnuzzbwartd"; // Use your 16-character App Password

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(fromEmail, "ITCTRLS Hiring Team");
            mail.To.Add(toEmail);
            mail.Subject = "Application Received - ITCTRLS -- Thank You " + fullName;
            mail.Body = messageContent;
            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential(fromEmail, appPassword);
            smtp.EnableSsl = true;
            smtp.Send(mail);
        }
    }
}
