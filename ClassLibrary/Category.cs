using System;

namespace ClassLibrary
{
    public class Category
    {
        public string Name {get; private set;}
        public Category(string name)
        {
            this.Name = name;
        }
    }
}
