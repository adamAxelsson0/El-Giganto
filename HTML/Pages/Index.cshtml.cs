using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using ClassLibrary;

namespace HTML.Pages
{
    public class IndexModel : PageModel
    {
        public int ProductSelection { get; set; }
        public Product currentProduct { get; set; }
        ClassLibrary.Database db = new ClassLibrary.Database
        ("Server=40.85.84.155;Database=ELGIGANTO5;User=Student5;Password=YH-student@2019;");
        public void OnGet()
        {
            ProductSelection = Convert.ToInt32(Request.Query["product"]);
            currentProduct = db.GetProducts(ProductInfo.Itemnumber)[ProductSelection];
        }
        public List<Product> ProductID(){
            return db.GetProducts(ProductInfo.Itemnumber);
        }
    }
}
