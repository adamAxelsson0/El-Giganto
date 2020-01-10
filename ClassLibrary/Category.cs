using System;

namespace ClassLibrary
{
    public class Category
    {
        public string Name {get; private set;}
        public ProductInfo ID {get; private set;}
        public Category(ProductInfo id, string name)
        {
            this.ID = id;
            this.Name = name;
        }
    }
}
