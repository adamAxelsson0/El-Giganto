using System;
using System.Data.SqlClient;
using Dapper;
using System.Collections.Generic;
using System.Linq;

namespace ClassLibrary
{
    public enum ProductInfo { Readable, Itemnumber, CPU = 43, MoBo = 44, Chassi = 45 }
    public enum CategoryInfo { Main = 1, ComputerComponents = 40 }
    public enum PopularityGain { Selected, AddedToCart, Ordered }
    public class Database
    {
        private readonly string connectionString;
        public Database(string connectionString)
        {
            this.connectionString = connectionString;
        }
        public List<Product> GetProducts(ProductInfo productInfo)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                if (productInfo == ProductInfo.Readable)
                {
                    return connection.Query<Product>($"Select * from dbo.ViewProductReadableInclID").AsList();
                }
                else if (productInfo == ProductInfo.Itemnumber)
                {
                    return connection.Query<Product>($"Select ItemNumber from Products").AsList();
                }
                else  //(productInfo == ProductInfo.CPU)
                {
                    return connection.Query<Product>("Select ViewProductReadableInclID.* "+
                     "from ViewProductReadableInclID " +
                    "inner join Products on ViewProductReadableInclID.ID = Products.ID "+
                    $"where Products.category = {Convert.ToInt32(productInfo)}").AsList();
                }
            }
        }
        public Product GetProduct(CategoryInfo category)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                return connection.Query<Product>($"Select v.* from dbo.ViewProductReadableInclID as v inner join Products "+
                $"where category = {Convert.ToInt32(category)}"+
                $" ").First();
            }
        }
        public Product GetProduct(string itemnumber)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                return connection.Query<Product>($"Select * from dbo.ViewProductReadableInclID where itemnumber = '{itemnumber}'").First();
            }
        }
        public void GainPopularity(int ID)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Query<Product>($"exec GainPopWhenSelected {ID}");
            }
        }
        public List<Category> GetCategories(CategoryInfo categoryInfo)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                if (categoryInfo == CategoryInfo.Main)
                {
                    return connection.Query<Category>($"Select ID, Name from Categories where parent = {Convert.ToInt32(categoryInfo)}").AsList();
                    
                }
                else
                {
                    return connection.Query<Category>($"Select ID, Name from Categories where parent = {Convert.ToInt32(categoryInfo)}").AsList();
                }
            }
        }
        public Category GetCategory(string category){
            using (var connection = new SqlConnection(connectionString))
            {
                return connection.Query<Category>($"Select ID, Name from Categories where name = '{category}'").First();
            } 
        }
        public void AddOrder()
        {
            using (var connection = new SqlConnection(connectionString))
            {
                connection.Query<Product>($"");
            }
        }
        public void AddToCart(Customer customer, Product product, int quantity)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                //costumer, product, quantity in order
                connection.Query<Product>($"exec AdjustCart {customer},{product},{quantity}");
            }
        }
    }
}
