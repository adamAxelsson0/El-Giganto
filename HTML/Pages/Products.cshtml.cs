using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using ClassLibrary;

namespace HTML.Pages
{
    public class ProductsModel : PageModel
    {
        public string ProductSelection { get; set; }
        public Product currentProduct { get; set; }
        ClassLibrary.Database db = new ClassLibrary.Database
        ("Server=40.85.84.155;Database=ELGIGANTO5;User=Student5;Password=YH-student@2019;");
        //public IEnumerable<Product> Products{get;private set;}
        public void OnGet()
        {
            ProductSelection = Request.Query["product"];
            currentProduct = db.GetProduct(ProductSelection);
            db.GainPopularity(currentProduct.ID);
        }
    }
}