using System;
using System.Data.SqlClient;
using Dapper;
using System.Collections.Generic;
using System.Linq;

namespace ClassLibrary
{
    public enum ProductInfo { Readable, Itemnumber }
    public enum CategoryInfo { Main }
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
                    var productList = connection.Query<Product>($"Select * from dbo.ViewProductReadableInclID").AsList();
                    return productList;
                }
                else if (productInfo == ProductInfo.Itemnumber)
                {
                    var itemList = connection.Query<Product>($"Select ItemNumber from Products").AsList();
                    return itemList;
                }
                else//needs to be something else
                {
                    var productList = connection.Query<Product>($"Select * from dbo.ViewProductReadableInclID").AsList();
                    return productList;
                }
            }
        }
        public Product GetProduct(string itemNumber)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                return connection.Query<Product>($"Select * from dbo.ViewProductReadableInclID where itemnumber = {itemNumber}").First();
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
                //if(categoryInfo == CategoryInfo.Main)
                var categoriesList = connection.Query<Category>($"Select Name from Categories where parent = 1").AsList();
                return categoriesList;
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
