<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Application.aspx.cs" Inherits="ITCTRLS_Task.Application" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Application Form</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            margin: 0;
            padding: 0;
        }
        .container {
            width: 450px;
            background: #fff;
            margin: 50px auto;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 12px;
        }
        label {
            font-weight: bold;
            display: block;
            color: #555;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="number"], input[type="email"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #bbb;
            border-radius: 6px;
            box-sizing: border-box;
        }
        .checkbox-group label {
            font-weight: normal;
            display: inline-block;
            margin-right: 15px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            background: #0078D7;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }
        .btn:hover {
            background: #005fa3;
        }
        .error {
            color: red;
            font-size: 13px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Application Form</h2>

          
            <div class="form-group">
                <label>Full Name:</label>
                <asp:TextBox ID="TxtBox" runat="server" />
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="TxtBox"
                    ErrorMessage="Full Name is required!" CssClass="error" Display="Dynamic" />
            </div>

            <div class="form-group">
                <label>Age:</label>
                <asp:TextBox ID="NAge" runat="server" TextMode="Number" />
                <asp:RequiredFieldValidator ID="rfvAge" runat="server" ControlToValidate="NAge"
                    ErrorMessage="Age is required!" CssClass="error" Display="Dynamic" />
                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="NAge"
                    MinimumValue="18" MaximumValue="100" Type="Integer"
                    ErrorMessage="Age must be between 18 and 100." CssClass="error" />
            </div>

         
            <div class="form-group">
                <label>Education:</label>
                <asp:TextBox ID="EBox" runat="server" />
                <asp:RequiredFieldValidator ID="rfvEdu" runat="server" ControlToValidate="EBox"
                    ErrorMessage="Education is required!" CssClass="error" Display="Dynamic" />
            </div>

           <div class="form-group">
      <label>Languages:</label>
      <div class="checkbox-group">
          <asp:CheckBoxList ID="CheckBox" runat="server" RepeatDirection="Horizontal">
              <asp:ListItem>.NET</asp:ListItem>
              <asp:ListItem>Java</asp:ListItem>
              <asp:ListItem>Python</asp:ListItem>
          </asp:CheckBoxList>
      </div>
  <asp:CustomValidator ID="cvLanguages" runat="server" OnServerValidate="ValidateLanguages"
      ErrorMessage="Please select at least one language!" CssClass="error" Display="Dynamic" />
  </div>

          
            <div class="form-group">
                <label>Father's Name:</label>
                <asp:TextBox ID="TxtFname" runat="server" />
                <asp:RequiredFieldValidator ID="rfvFather" runat="server" ControlToValidate="TxtFname"
                    ErrorMessage="Father's name is required!" CssClass="error" Display="Dynamic" />
            </div>

        
            <div class="form-group">
                <label>Mobile Number:</label>
                <asp:TextBox ID="MNumbetrt" runat="server" MaxLength="10" />
                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="MNumbetrt"
                    ErrorMessage="Mobile number is required!" CssClass="error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="MNumbetrt"
                    ValidationExpression="^[0-9]{10}$"
                    ErrorMessage="Enter a valid 10-digit mobile number!" CssClass="error" Display="Dynamic" />
            </div>

          
            <div class="form-group">
                <label>Email:</label>
                <asp:TextBox ID="EmailTxt" runat="server" TextMode="Email" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="EmailTxt"
                    ErrorMessage="Email is required!" CssClass="error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="EmailTxt"
                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                    ErrorMessage="Enter a valid email address!" CssClass="error" Display="Dynamic" />
            </div>

         
            <div class="form-group">
                <label>Message:</label>
                <asp:TextBox ID="TxtMessage" runat="server" TextMode="MultiLine" Rows="3" />
                <asp:RequiredFieldValidator ID="rfvMsg" runat="server" ControlToValidate="TxtMessage"
                    ErrorMessage="Message is required!" CssClass="error" Display="Dynamic" />
            </div>

          
            <div class="form-group">
                <label>Upload Image:</label>
                <asp:FileUpload ID="FileUploadImage" runat="server" />
                <asp:RequiredFieldValidator ID="rfvFile" runat="server" ControlToValidate="FileUploadImage"
                    InitialValue="" ErrorMessage="Please upload an image!" CssClass="error" Display="Dynamic" />
            </div>

            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" HeaderText="Please fix the following errors:" />

            <asp:Button ID="ButtonSubmit" runat="server" Text="Submit Application"
                CssClass="btn" OnClick="Button_Click" />
        </div>
    </form>
</body>
</html> 