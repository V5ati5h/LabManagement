using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabManagement.Dashboard
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(ConfigurationManager.ConnectionStrings["strcon"].ConnectionString);
            loadDepart();
        }

        protected void loadDepart()
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("select * from Tbl_Categories", conn);
            cmd.CommandType = CommandType.Text;
            ddCat.DataSource = cmd.ExecuteReader();
            ddCat.DataTextField = "name";
            ddCat.DataValueField = "id";
            ddCat.DataBind();
            ddCat.Items.Insert(0, new ListItem("Select Categories", "0"));
            conn.Close();
        }

        protected void insertData(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Tbl_Items(code, name, category, supplier, quantity, purchesePrice, available, expirationDate, lastUpdate) VALUES (@code, @name, @category, @supplier, @quantity, @purchesePrice, @available, @expirationDate, @lastUpdate);", conn)
                {
                    CommandType = CommandType.Text
                };
                cmd.Parameters.AddWithValue("@code", code.Text);
                cmd.Parameters.AddWithValue("@name", name.Text);
                cmd.Parameters.AddWithValue("@category", Convert.ToString(ddCat.SelectedItem));
                cmd.Parameters.AddWithValue("@supplier", supplier.Text);
                cmd.Parameters.AddWithValue("@quantity", quantity.Text);
                cmd.Parameters.AddWithValue("@purchesePrice", pPrice.Text);
                cmd.Parameters.AddWithValue("@available", avilable.Text);
                cmd.Parameters.AddWithValue("@expirationDate", eDate.Text);
                cmd.Parameters.AddWithValue("@lastUpdate", DateTime.Now.ToString());
                conn.Open();
                int k = cmd.ExecuteNonQuery();
                if (k != 0)
                {
                    Response.Redirect("Inventory.aspx");
                }
                conn.Close();

            }
            catch (Exception ex)
            {
            }
        }

        protected void ddCat_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }
}