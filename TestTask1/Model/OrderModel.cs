using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestTask1
{
    internal class OrderModel
    {
        
        public int ID { get; set; }

       
        public DateTime Date { get; set; }
        
        public double Amount { get; set; }

        public double PaymentAmount { get; set; }
        public bool Equals(OrderModel x)
        {
            if (x != null)
            {
                if (x.ID == ID && x.Date== Date && x.Amount== Amount && x.PaymentAmount==PaymentAmount)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else return false;

        }
    }
}
