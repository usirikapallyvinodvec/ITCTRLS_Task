<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="ITCTRLS_Task.LoginPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Login</title>
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

        h1 {
            text-align: center;
            color: #2c3e50;
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
            padding: 10px;
            border: none;
            border-radius: 5px;
            width: 100%;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        .button:hover {
            background-color: #2980b9;
        }

        .register-btn {
            background-color: #2ecc71;
        }

        .register-btn:hover {
            background-color: #27ae60;
        }

        .error {
            color: red;
            font-size: 13px;
        }

        #Msg {
            display: block;
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>User Login</h1>

        <label for="UN">Username:</label><br />
        <asp:TextBox runat="server" ID="UN" CssClass="textbox" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Username is required" ForeColor="Red" ControlToValidate="UN" CssClass="error" /><br />

        <label for="PD">Password:</label><br />
        <asp:TextBox runat="server" ID="PD" TextMode="Password" CssClass="textbox" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Password is required" ForeColor="Red" ControlToValidate="PD" CssClass="error" /><br />

        <asp:Button ID="BT" runat="server" Text="Login" OnClick="BT_Click" CssClass="button" />
        <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="button register-btn" OnClick="btnRegister_Click" />

        <asp:Label ID="Msg" runat="server" Font-Bold="true"></asp:Label>
    </form>
</body>
</html>
