<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Application.aspx.cs" Inherits="ITCTRLS_Task.Application" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Application Form</title>
    <style>
     
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }

      
        .container {
            background: #ffffff;
            padding: 50px 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            width: 450px;
            transition: all 0.3s ease;
        }

        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }

      
        h2 {
            text-align: center;
            color: #004d80;
            font-size: 30px;
            font-weight: 700;
            margin-bottom: 35px;
        }

       
        label {
            display: block;
            margin-top: 18px;
            font-weight: 600;
            color: #333333;
            font-size: 15px;
        }

       
        input[type="text"], input[type="email"], textarea {
            width: 100%;
            padding: 12px 15px;
            margin-top: 6px;
            border-radius: 12px;
            border: 1.5px solid #cfd8dc;
            font-size: 14px;
            outline: none;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus, input[type="email"]:focus, textarea:focus {
            border-color: #004d80;
            box-shadow: 0 0 10px rgba(0,77,128,0.25);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

       
        .checkbox-inline {
            display: flex;
            gap: 25px;
            margin-top: 8px;
        }

        .checkbox-inline label {
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
        }

        
        .btn {
            background-color: #004d80;
            color: #ffffff;
            padding: 14px 0;
            border: none;
            width: 100%;
            border-radius: 12px;
            margin-top: 30px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #003366;
            box-shadow: 0 5px 15px rgba(0,51,102,0.4);
        }

       
        .validator {
            color: #d32f2f;
            font-size: 13px;
            margin-top: 4px;
        }

       
        .msg {
            margin-top: 20px;
            font-weight: 600;
            font-size: 15px;
            text-align: center;
            color: green;
        }

        @media (max-width: 500px) {
            .container {
                width: 90%;
                padding: 40px 20px;
            }
        }
    </style>

    <script>
        function addGmail() {
            var emailInput = document.getElementById("<%= EmailTxt.ClientID %>");
            if (emailInput.value && !emailInput.value.includes("@")) {
                emailInput.value += "@gmail.com";
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Application Form</h2>

            <label>Full Name:</label>
            <asp:TextBox ID="TxtBox" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name is required" ForeColor="Red" ControlToValidate="TxtBox" CssClass="validator"></asp:RequiredFieldValidator>

            <label>Age:</label>
            <asp:TextBox ID="NAge" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Age is required" ForeColor="Red" ControlToValidate="NAge" CssClass="validator"></asp:RequiredFieldValidator>

            <label>Education:</label>
            <asp:TextBox ID="EBox" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Education is required" ForeColor="Red" ControlToValidate="EBox" CssClass="validator"></asp:RequiredFieldValidator>

            <label>Languages:</label>
            <asp:CheckBoxList ID="CheckBox" runat="server" CssClass="checkbox-inline" RepeatDirection="Horizontal">
                <asp:ListItem Text=".NET" Value=".NET"></asp:ListItem>
                <asp:ListItem Text="Java" Value="Java"></asp:ListItem>
                <asp:ListItem Text="Python" Value="Python"></asp:ListItem>
            </asp:CheckBoxList>

            <label>Father Name:</label>
            <asp:TextBox ID="TxtFname" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Father name is required" ForeColor="Red" ControlToValidate="TxtFname" CssClass="validator"></asp:RequiredFieldValidator>

            <label>Mobile No:</label>
            <asp:TextBox ID="MNumbetrt" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Mobile number is required" ForeColor="Red" ControlToValidate="MNumbetrt" CssClass="validator"></asp:RequiredFieldValidator>

            <label>Email:</label>
            <asp:TextBox ID="EmailTxt" runat="server" onblur="addGmail()"></asp:TextBox>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email" ForeColor="Red" ControlToValidate="EmailTxt" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="validator"></asp:RegularExpressionValidator>

            <label>Message:</label>
            <asp:TextBox ID="TxtMessage" runat="server" TextMode="MultiLine" Rows="5" Placeholder="Write your message here..."></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorMsg" runat="server" ErrorMessage="Message is required" ForeColor="Red" ControlToValidate="TxtMessage" CssClass="validator"></asp:RequiredFieldValidator>

            <asp:Button ID="Button" runat="server" CssClass="btn" Text="Save" OnClick="Button_Click" />
            <asp:Label ID="MsgLabel" runat="server" CssClass="msg"></asp:Label>
        </div>
    </form>
</body>
</html>
