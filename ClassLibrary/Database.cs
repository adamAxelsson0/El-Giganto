using System;
using System.Data.SqlClient;
using Dapper;
using System.Collections.Generic;
using System.Linq;

namespace ClassLibrary
{
    public class Database
    {
        private readonly string connectionString;
        public Database(string connectionString)
        {
            this.connectionString = connectionString;
        }
        public List<Product> GetProductsForUser()
        {
            //var productList = new List<Product>();
            using (var connection = new SqlConnection(connectionString))
            {
                var productList = connection.Query<Product>($"Select * from ViewProductReadable").AsList();
                return productList;
            }
        }
        public void AddOrder()
        {
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Query<Product>($"");
            }
        }
    }
}
