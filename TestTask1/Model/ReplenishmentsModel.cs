using System;
using TestTask1.BD;

namespace TestTask1.Model
{
    internal class ReplenishmentsModel
    {
        public int ID { get; set; }

        public DateTime Date { get; set; }

        public double Amount { get; set; }

        public double Remains { get; set; }

        public ReplenishmentsModel(Replenishments x)
        {
            ID = x.ID;
            Date = x.Date;
            Amount = x.Amount;
            Remains = x.Remains;
        }

        public bool Equals(ReplenishmentsModel x)
        {
            if (x != null)
            {
                if (x.ID == ID && x.Date == Date && x.Amount == Amount && x.Remains == Remains)
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
