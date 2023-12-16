using System.Configuration;
using System.Data.SqlClient;
using System;

namespace LabManagement.Dashboard
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ConnectionString);

            tItem.Text = loadkar("SELECT COUNT(*) FROM Tbl_Items");

            cItem.Text = loadkar("SELECT COUNT(*) FROM Tbl_Items WHERE Quantity < 10");

            tLowStock.Text = loadkar("SELECT COUNT(*) FROM Tbl_Items WHERE Quantity BETWEEN 10 AND 50");

            tExpired.Text = loadkar("SELECT COUNT(*) FROM Tbl_Items WHERE ExpirationDate < GETDATE()");
        }

        protected String loadkar(String txt)
        {
            string rst;
            conn.Open();
            SqlCommand cmd = new SqlCommand(txt, conn);
            rst = Convert.ToString(cmd.ExecuteScalar());
            conn.Close();
            return rst;
        }
    }
}
