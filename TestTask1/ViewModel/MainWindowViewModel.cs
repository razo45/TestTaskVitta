using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TestTask1.BD;
using TestTask1.Model;

namespace TestTask1.ViewModel
{
    internal class MainWindowViewModel
    {
       public List<OrderModel> GridOrders { get; set; }
       public List<ReplenishmentsModel> GridReplenishments { get; set; }
       public List<Payments> GridPayments { get; set; }
        public MainWindowViewModel(List<OrderModel> ListOrder, List<Payments> ListPayments, List<ReplenishmentsModel> ListReplenishments)
        {
            GridOrders = ListOrder;
            GridPayments = ListPayments;
            GridReplenishments = ListReplenishments;
            
        }

    }
 
}
