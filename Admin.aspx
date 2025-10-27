<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="ITCTRLS_Task.Admin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f0f4ff, #dfe9ff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0px 0px 15px rgba(0,0,0,0.2);
            width: 350px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-top: 5px;
        }
        .btn {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            width: 100%;
            border-radius: 8px;
            margin-top: 15px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .msg {
            margin-top: 15px;
            font-weight: bold;
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Admin Login</h2>

            <label>Admin Name:</label>
            <asp:TextBox ID="TxtAdminName" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="ReqAdminName" runat="server" ControlToValidate="TxtAdminName" 
                ErrorMessage="Admin name required" ForeColor="Red"></asp:RequiredFieldValidator>

            <label>Password:</label>
            <asp:TextBox ID="TxtPassword" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="ReqPassword" runat="server" ControlToValidate="TxtPassword" 
                ErrorMessage="Password required" ForeColor="Red"></asp:RequiredFieldValidator>

            <asp:Button ID="BtnLogin" runat="server" CssClass="btn" Text="Login" OnClick="BtnLogin_Click" />
            <asp:Label ID="MsgLabel" runat="server" CssClass="msg"></asp:Label>
        </div>
    </form>
</body>
</html>
