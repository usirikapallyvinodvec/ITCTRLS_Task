<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ITCTRLS_Task.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #eef3ff, #dce6ff);
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #004aad;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .grid-container {
            width: 95%;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
        }

        .gridview th {
            background-color: #007bff;
            color: white;
            padding: 10px;
            text-align: left;
        }

        .gridview td {
            border: 1px solid #ccc;
            padding: 10px;
        }

        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
        }

        .btn-view {
            background-color: #17a2b8;
            color: white;
        }

        .btn-delete {
            background-color: #dc3545;
            color: white;
        }

        .btn-logout {
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 18px;
            margin-top: 20px;
            float: right;
            cursor: pointer;
        }

        .details-panel {
            display: none;
            margin-top: 20px;
            background-color: #f9fbff;
            padding: 15px;
            border-radius: 10px;
            border: 1px solid #cfd8dc;
        }

        .details-panel h3 {
            color: #007bff;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Admin Dashboard - Applicant Details</h2>
        <div class="grid-container">
            <asp:GridView ID="GridViewApplicants" runat="server" AutoGenerateColumns="False"
                CssClass="gridview" OnRowCommand="GridViewApplicants_RowCommand">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                    <asp:BoundField DataField="Age" HeaderText="Age" />
                    <asp:BoundField DataField="Education" HeaderText="Education" />
                    <asp:BoundField DataField="Languages" HeaderText="Languages" />
                    <asp:BoundField DataField="FatherName" HeaderText="Father Name" />
                    <asp:BoundField DataField="MobileNumber" HeaderText="Mobile No." />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="MessageBox" HeaderText="Message" />

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button runat="server" CommandName="View" CommandArgument='<%# Eval("Email") %>'
                                Text="View" CssClass="btn btn-view" />
                            <asp:Button runat="server" CommandName="Del" CommandArgument='<%# Eval("Email") %>'
                                Text="Delete" CssClass="btn btn-delete"
                                OnClientClick="return confirm('Are you sure you want to delete this record?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="details-panel" id="DetailsPanel" runat="server">
                <h3>Applicant Details</h3>
                <asp:Literal ID="LiteralDetails" runat="server"></asp:Literal>
            </div>
        </div>

        <asp:Button ID="BtnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="BtnLogout_Click" />
    </form>
</body>
</html>
