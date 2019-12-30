using System;

namespace ClassLibrary
{
    public class Product
    {
        public string ItemNumber { get; private set; }
        public string Category { get; private set; }
        public string Name { get; private set; }
        public string Brand { get; private set; }
        public decimal Price { get; private set; }
        public string Description { get; private set; }
        public string ImageURL { get; private set; }
        public DateTime ReleaseDate { get; private set; }
        public string Status { get; private set; }
        public double QuantityAvailable { get; private set; }

        public Product(string itemnumber, string category, string name, string brand, decimal price,
        string description, string imageURL, DateTime releaseDate, string status,
        int quantityAvailable)
        {
            this.ItemNumber = itemnumber;
            this.Category = category;
            this.Name = name;
            this.Brand = brand;
            this.Price = price;
            this.Description = description;
            this.ImageURL = imageURL;
            this.ReleaseDate = releaseDate;
            this.Status = status;
            this.QuantityAvailable = quantityAvailable;
        }
        public Product()
        {

        }
    }
}
