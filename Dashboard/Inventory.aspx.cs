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
            loadData();
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
        protected void loadData()
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM Tbl_Items", conn);
            cmd.CommandType = CommandType.Text;
            conn.Open();
            SqlDataAdapter dsa = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            dsa.Fill(dt);
            gridview.DataSource = dt;
            gridview.DataBind();
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

        protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridview.PageIndex = e.NewPageIndex;
            loadData();
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            gridview.EditIndex = e.NewEditIndex;
            loadData();
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {

                GridViewRow row = gridview.Rows[e.RowIndex];
                int id = Convert.ToInt32(gridview.DataKeys[e.RowIndex].Values[0]);
                string code = (row.Cells[2].Controls[0] as TextBox).Text;
                string name = (row.Cells[3].Controls[0] as TextBox).Text;
                string category = (row.Cells[4].Controls[0] as TextBox).Text;
                string supplier = (row.Cells[5].Controls[0] as TextBox).Text;
                string quantity = (row.Cells[6].Controls[0] as TextBox).Text;
                string purchesePrice = (row.Cells[7].Controls[0] as TextBox).Text;
                string available = (row.Cells[8].Controls[0] as TextBox).Text;
                string expirationDate = (row.Cells[9].Controls[0] as TextBox).Text;
                string lastUpdate = (row.Cells[10].Controls[0] as TextBox).Text;
                SqlCommand cmd = new SqlCommand("usp_Tbl_Student_UPDATE", conn);
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@code", code);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@category", category);
                cmd.Parameters.AddWithValue("@supplier", supplier);
                cmd.Parameters.AddWithValue("@quantity", quantity);
                cmd.Parameters.AddWithValue("@purchesePrice", purchesePrice);
                cmd.Parameters.AddWithValue("@available", available);
                cmd.Parameters.AddWithValue("@expirationDate", expirationDate);
                cmd.Parameters.AddWithValue("@lastUpdate", lastUpdate);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                gridview.EditIndex = -1;
                loadData();

            }
            catch (Exception ex)
            {

            }
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            gridview.EditIndex = -1;
            loadData();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridViewRow row = gridview.Rows[e.RowIndex];
            int studentId = Convert.ToInt32(value: gridview.DataKeys[e.RowIndex].Values[0]);
            SqlCommand cmd = new SqlCommand("delete FROM Tbl_Items where id = @id", conn);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@id", studentId);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != gridview.EditIndex)
            {
                (e.Row.Cells[0].Controls[2] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
            }
        }

        protected void ddCat_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}