using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;  

namespace ITCTRLS_Task
{
    public partial class Application : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                ClearFields();
        }

        private void ClearFields()
        {
            TxtBox.Text = NAge.Text = EBox.Text = TxtFname.Text = MNumbetrt.Text = EmailTxt.Text = TxtMessage.Text = "";
            CheckBox.ClearSelection();
        }

        protected void ValidateLanguages(object source, ServerValidateEventArgs args)
        {
            args.IsValid = false;
            foreach (ListItem item in CheckBox.Items)
            {
                if (item.Selected)
                {
                    args.IsValid = true;
                    break;
                }
            }
        }

        protected void Button_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            if (MNumbetrt.Text.Trim().Length != 10)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mobile number must be exactly 10 digits!');", true);
                return;
            }

            string photoPath = null;
            if (FileUploadImage.HasFile)
            {
                string folderPath = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(FileUploadImage.FileName);
                string savePath = Path.Combine(folderPath, fileName);
                FileUploadImage.SaveAs(savePath);
                photoPath = "Uploads/" + fileName;  
            }

          
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Applicants 
                                (FullName, Age, Education, Languages, FatherName, MobileNumber, Email, MessageBox, PhotoPath) 
                                VALUES (@FullName, @Age, @Education, @Languages, @FatherName, @MobileNumber, @Email, @MessageBox, @PhotoPath)";
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
                    cmd.Parameters.AddWithValue("@PhotoPath", (object)photoPath ?? DBNull.Value);  
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            try
            {
              
                SendMailToApplicant(EmailTxt.Text.Trim(), TxtBox.Text.Trim(), TxtMessage.Text.Trim());
                SendMailToAdmin(TxtBox.Text.Trim(), NAge.Text.Trim(), EBox.Text.Trim(), GetSelectedLanguages(),
                                TxtFname.Text.Trim(), MNumbetrt.Text.Trim(), EmailTxt.Text.Trim(), TxtMessage.Text.Trim());

                ClientScript.RegisterStartupScript(this.GetType(), "success",
                    "alert('Application submitted successfully! Email sent to both applicant and admin.');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "fail",
                    $"alert('Application saved, but email sending failed: {ex.Message}');", true);
            }

            ClearFields();
        }

        private string GetSelectedLanguages()
        {
            string langs = "";
            foreach (ListItem item in CheckBox.Items)
                if (item.Selected)
                    langs += (langs == "" ? "" : ", ") + item.Text;
            return langs;
        }

        private void SendMailToApplicant(string toEmail, string fullName, string message)
        {
            string fromEmail = "usirikapallyvinod8465@gmail.com";
            string appPassword = "rmokdmnuzzbwartd";

            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(fromEmail, "ITCTRLS Hiring Team");
            mail.To.Add(toEmail);
            mail.Subject = $"Application Received - Thank You {fullName}";
            mail.Body = $"Dear {fullName},\n\nThank you for applying at ITCTRLS.\n\nYour message: {message}\n\nWe’ll contact you soon.";
            new SmtpClient("smtp.gmail.com", 587)
            {
                Credentials = new NetworkCredential(fromEmail, appPassword),
                EnableSsl = true
            }.Send(mail);
        }

        private void SendMailToAdmin(string name, string age, string education, string languages,
                                     string father, string mobile, string email, string message)
        {
            string fromEmail = "usirikapallyvinod8465@gmail.com";
            string appPassword = "rmokdmnuzzbwartd";
            string adminEmail = "itctrls.hiring@gmail.com";

            string body = $@"
                New applicant details:

                Full Name: {name}
                Age: {age}
                Education: {education}
                Languages: {languages}
                Father's Name: {father}
                Mobile: {mobile}
                Email: {email}
                Message: {message}";

            new SmtpClient("smtp.gmail.com", 587)
            {
                Credentials = new NetworkCredential(fromEmail, appPassword),
                EnableSsl = true
            }.Send(new MailMessage(fromEmail, adminEmail, "New Applicant - " + name, body));
        }
    }
}
