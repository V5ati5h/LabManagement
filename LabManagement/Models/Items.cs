using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LabManagement.Models
{
    public class Items
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public int CategoryId { get; set; }
        public int ForStud {  get; set; }
        public string Supplier { get; set; }
        public long Quantity { get; set; }
        public long PurchesePrice { get; set; }
        public string Available { get; set; }
        public string ExpirationDate { get; set; }
        public string LastUpdate { get; set; }
    }
}