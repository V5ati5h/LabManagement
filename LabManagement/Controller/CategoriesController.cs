using LabManagement.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Web.Http;

namespace LabManagement.Controller
{
    public class CategoriesController : ApiController
    {
        private readonly string ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnString"].ConnectionString;

        // GET: api/categories
        public async Task<IHttpActionResult> GetCategories()
        {
            try
            {
                var categories = new List<Categories>();

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("SELECT * FROM Tbl_Categories", connection))
                    {
                        using (SqlDataReader reader = await command.ExecuteReaderAsync())
                        {
                            while (await reader.ReadAsync())
                            {
                                categories.Add(new Categories
                                {
                                    Id = reader.GetInt32(0),
                                    Name = reader.GetString(1),
                                    Description = reader.IsDBNull(2) ? null : reader.GetString(2),
                                    LastUpdate = reader.IsDBNull(3) ? null : reader.GetString(3)
                                });
                            }
                        }
                    }
                }

                return Ok(categories);
            }
            catch (Exception ex)
            {
                // Log the exception
                return InternalServerError(ex);
            }
        }

        // GET: api/categories/1
        public async Task<IHttpActionResult> GetCategory(int id)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("SELECT * FROM Tbl_Categories WHERE Id = @Id", connection))
                    {
                        command.Parameters.AddWithValue("@Id", id);

                        using (SqlDataReader reader = await command.ExecuteReaderAsync())
                        {
                            if (await reader.ReadAsync())
                            {
                                var category = new Categories
                                {
                                    Id = reader.GetInt32(0),
                                    Name = reader.GetString(1),
                                    Description = reader.IsDBNull(2) ? null : reader.GetString(2),
                                    LastUpdate = reader.IsDBNull(3) ? null : reader.GetString(3)
                                };

                                return Ok(category);
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

        // POST: api/categories
        public async Task<IHttpActionResult> PostCategory(Categories category)
        {
            try
            {
                // Input validation
                if (string.IsNullOrEmpty(category.Name))
                {
                    return BadRequest("Category name cannot be empty.");
                }

                if (!ModelState.IsValid)
                {
                    return BadRequest(ModelState);
                }

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("INSERT INTO Tbl_Categories (Name, Description, LastUpdate) VALUES (@Name, @Description, @LastUpdate); SELECT SCOPE_IDENTITY();", connection))
                    {
                        command.Parameters.AddWithValue("@Name", category.Name);
                        command.Parameters.AddWithValue("@Description", category.Description ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@LastUpdate", DateTime.Now.ToString());

                        int newCategoryId = Convert.ToInt32(await command.ExecuteScalarAsync());
                        category.Id = newCategoryId;

                        return CreatedAtRoute("DefaultApi", new { id = newCategoryId }, category);
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                // Consider using a logging library like Serilog, NLog, or log4net
                Console.WriteLine(ex);
                return InternalServerError(ex);
            }
        }


        // PUT: api/categories/1
        public async Task<IHttpActionResult> PutCategory(int id, Categories category)
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

                    using (SqlCommand command = new SqlCommand("UPDATE Tbl_Categories SET Name = @Name, Description = @Description, LastUpdate = @LastUpdate WHERE Id = @Id", connection))
                    {
                        command.Parameters.AddWithValue("@Id", id);
                        command.Parameters.AddWithValue("@Name", category.Name);
                        command.Parameters.AddWithValue("@Description", category.Description ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@LastUpdate", DateTime.Now.ToString());

                        int rowsAffected = await command.ExecuteNonQueryAsync();

                        if (rowsAffected > 0)
                        {
                            // Fetch the updated category and return it
                            var updatedCategory = await GetCategoryById(id);
                            return Ok(updatedCategory);
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

        // DELETE: api/categories/1
        public async Task<IHttpActionResult> DeleteCategory(int id)
        {
            try
            {
                // Fetch the category before deletion
                var categoryToDelete = await GetCategoryById(id);

                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    await connection.OpenAsync();

                    using (SqlCommand command = new SqlCommand("DELETE FROM Tbl_Categories WHERE Id = @Id", connection))
                    {
                        command.Parameters.AddWithValue("@Id", id);

                        int rowsAffected = await command.ExecuteNonQueryAsync();

                        if (rowsAffected > 0)
                        {
                            // Return the deleted category
                            return Ok(categoryToDelete);
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

        // Helper method to fetch a category by ID
        private async Task<Categories> GetCategoryById(int id)
        {
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                await connection.OpenAsync();

                using (SqlCommand command = new SqlCommand("SELECT * FROM Tbl_Categories WHERE Id = @Id", connection))
                {
                    command.Parameters.AddWithValue("@Id", id);

                    using (SqlDataReader reader = await command.ExecuteReaderAsync())
                    {
                        if (await reader.ReadAsync())
                        {
                            var category = new Categories
                            {
                                Id = reader.GetInt32(0),
                                Name = reader.GetString(1),
                                Description = reader.IsDBNull(2) ? null : reader.GetString(2),
                                LastUpdate = reader.IsDBNull(3) ? null : reader.GetString(3)
                            };

                            return category;
                        }
                        else
                        {
                            return null;
                        }
                    }
                }
            }
        }
    }
}
