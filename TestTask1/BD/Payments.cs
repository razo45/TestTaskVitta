namespace TestTask1.BD
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Payments
    {
        public int ID { get; set; }

        public int OrderID { get; set; }

        public int ReplenishmentID { get; set; }

        public double Amount { get; set; }

        public virtual Orders Orders { get; set; }

        public virtual Replenishments Replenishments { get; set; }
    }
}
