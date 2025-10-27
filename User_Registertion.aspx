<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_Registration.aspx.cs" Inherits="ITCTRLS_Task.User_Registration" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f6fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #ffffff;
            border: 2px solid #3498db;
            border-radius: 10px;
            padding: 30px;
            width: 350px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        .textbox {
            width: 100%;
            padding: 8px;
            margin: 8px 0 12px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .button {
            background-color: #3498db;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            width: 100%;
            cursor: pointer;
            font-size: 16px;
        }

        .button:hover {
            background-color: #2980b9;
        }

        .error {
            color: red;
            font-size: 13px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>User Registration</h2>

        <label for="txtname">Name:</label><br />
        <asp:TextBox ID="txtname" runat="server" CssClass="textbox" />
        <asp:RequiredFieldValidator ID="R" runat="server" ErrorMessage="* Name is required" ForeColor="Red" ControlToValidate="txtname" CssClass="error" /><br />

        <label for="txtpassword">Password:</label><br />
        <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" CssClass="textbox" />
        <asp:RequiredFieldValidator ID="txtRf" runat="server" ErrorMessage="* Password is required" ForeColor="Red" ControlToValidate="txtpassword" CssClass="error" /><br />

        <label for="txtconfirmpassword">Confirm Password:</label><br />
        <asp:TextBox ID="txtconfirmpassword" runat="server" TextMode="Password" CssClass="textbox" />
        <asp:CompareValidator ID="cv" runat="server" ErrorMessage="* Passwords must match" ForeColor="Red" ControlToValidate="txtconfirmpassword" ControlToCompare="txtpassword" CssClass="error" /><br />

        <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="Unnamed_Click" CssClass="button" />
    </form>
</body>
</html>
