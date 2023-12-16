using LabManagement.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Web.Http;

namespace LabManagement.Controller
{
    public class ItemsController : ApiController
    {
        private readonly string ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnString"].ConnectionString;

        // GET: api/items
        public async Task<IHttpActionResult> GetItems()
        {
            try
            {
                var items = new List<Items>();

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("SELECT * FROM Tbl_Items", connection))
                    {
                        using (SqlDataReader reader = await command.ExecuteReaderAsync())
                        {
                            while (await reader.ReadAsync())
                            {
                                items.Add(new Items
                                {
                                    Id = reader.GetInt32(0),
                                    CategoryId = reader.GetInt32(1),
                                    ForStud = reader.GetInt32(2),
                                    Code = reader.IsDBNull(3) ? null : reader.GetString(3),
                                    Name = reader.IsDBNull(4) ? null : reader.GetString(4),
                                    Available = reader.IsDBNull(5) ? null : reader.GetString(5),
                                    Quantity = reader.GetInt64(6),
                                    Supplier = reader.IsDBNull(7) ? null : reader.GetString(7),
                                    PurchesePrice = reader.GetInt64(8),
                                    ExpirationDate = reader.IsDBNull(9) ? null : reader.GetString(9),
                                    LastUpdate = reader.IsDBNull(10) ? null : reader.GetString(10)
                                });
                            }
                        }
                    }
                }

                return Ok(items);
            }
            catch (Exception ex)
            {
                // Log the exception
                return InternalServerError(ex);
            }
        }

        // GET: api/items/1
        public async Task<IHttpActionResult> GetItem(int id)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("SELECT * FROM Tbl_Items WHERE Id = @Id", connection))
                    {
                        command.Parameters.AddWithValue("@Id", id);

                        using (SqlDataReader reader = await command.ExecuteReaderAsync())
                        {
                            if (await reader.ReadAsync())
                            {
                                var item = new Items
                                {
                                    Id = reader.GetInt32(0),
                                    CategoryId = reader.GetInt32(1),
                                    ForStud = reader.GetInt32(2),
                                    Code = reader.IsDBNull(3) ? null : reader.GetString(3),
                                    Name = reader.IsDBNull(4) ? null : reader.GetString(4),
                                    Available = reader.IsDBNull(5) ? null : reader.GetString(5),
                                    Quantity = reader.GetInt64(6),
                                    Supplier = reader.IsDBNull(7) ? null : reader.GetString(7),
                                    PurchesePrice = reader.GetInt64(8),
                                    ExpirationDate = reader.IsDBNull(9) ? null : reader.GetString(9),
                                    LastUpdate = reader.IsDBNull(10) ? null : reader.GetString(10)
                                };

                                return Ok(item);
                            }
                            else
                            {
                                return NotFound();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                return InternalServerError(ex);
            }
        }

        // POST: api/items
        public async Task<IHttpActionResult> PostItem(Items item)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("INSERT INTO Tbl_Items (cid, forStud, code, name, available, quantity, supplier, purchesePrice, expirationDate, lastUpdate) VALUES (@CategoryId, @ForStud, @Code, @Name, @Available, @Quantity, @Supplier, @PurchesePrice, @ExpirationDate, @LastUpdate); SELECT SCOPE_IDENTITY();", connection))
                    {
                        command.Parameters.AddWithValue("@CategoryId", item.CategoryId);
                        command.Parameters.AddWithValue("@ForStud", item.ForStud);
                        command.Parameters.AddWithValue("@Code", item.Code ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@Name", item.Name ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@Available", item.Available ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@Quantity", item.Quantity);
                        command.Parameters.AddWithValue("@Supplier", item.Supplier ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@PurchesePrice", item.PurchesePrice);
                        command.Parameters.AddWithValue("@ExpirationDate", item.ExpirationDate ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@LastUpdate", DateTime.UtcNow.ToString());

                        int newItemId = Convert.ToInt32(await command.ExecuteScalarAsync());
                        item.Id = newItemId;

                        return CreatedAtRoute("DefaultApi", new { id = newItemId }, item);
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                return InternalServerError(ex);
            }
        }

        // PUT: api/items/1
        public async Task<IHttpActionResult> PutItem(int id, Items item)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("UPDATE Tbl_Items SET cid = @CategoryId, forStud = @ForStud, code = @Code, name = @Name, available = @Available, quantity = @Quantity, supplier = @Supplier, purchesePrice = @PurchesePrice, expirationDate = @ExpirationDate, lastUpdate = @LastUpdate WHERE Id = @Id", connection))
                    {
                        command.Parameters.AddWithValue("@Id", id);
                        command.Parameters.AddWithValue("@CategoryId", item.CategoryId);
                        command.Parameters.AddWithValue("@ForStud", item.ForStud);
                        command.Parameters.AddWithValue("@Code", item.Code ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@Name", item.Name ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@Available", item.Available ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@Quantity", item.Quantity);
                        command.Parameters.AddWithValue("@Supplier", item.Supplier ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@PurchesePrice", item.PurchesePrice);
                        command.Parameters.AddWithValue("@ExpirationDate", item.ExpirationDate ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@LastUpdate", DateTime.UtcNow.ToString());

                        int rowsAffected = await command.ExecuteNonQueryAsync();

                        if (rowsAffected > 0)
                        {
                            return Ok(item);
                        }
                        else
                        {
                            return NotFound();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                return InternalServerError(ex);
            }
        }

        // DELETE: api/items/1
        public async Task<IHttpActionResult> DeleteItem(int id)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("DELETE FROM Tbl_Items WHERE Id = @Id", connection))
                    {
                        command.Parameters.AddWithValue("@Id", id);

                        int rowsAffected = await command.ExecuteNonQueryAsync();

                        if (rowsAffected > 0)
                        {
                            return Ok();
                        }
                        else
                        {
                            return NotFound();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                return InternalServerError(ex);
            }
        }

    }
}
