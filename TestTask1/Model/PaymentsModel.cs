using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestTask1.Model
{
    internal class PaymentsModel
    {
        public int ID { get; set; }

        public int OrderID { get; set; }

        public int ReplenishmentID { get; set; }

        public double Amount { get; set; }
    }
}
