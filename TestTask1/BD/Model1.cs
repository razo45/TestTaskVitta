using System;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;

namespace TestTask1.BD
{
    public partial class Model1 : DbContext
    {
        public Model1()
            : base("name=Model1")
        {
        }

        public virtual DbSet<Orders> Orders { get; set; }
        public virtual DbSet<Payments> Payments { get; set; }
        public virtual DbSet<Replenishments> Replenishments { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Orders>()
                .HasMany(e => e.Payments)
                .WithRequired(e => e.Orders)
                .HasForeignKey(e => e.OrderID)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<Replenishments>()
                .HasMany(e => e.Payments)
                .WithRequired(e => e.Replenishments)
                .HasForeignKey(e => e.ReplenishmentID)
                .WillCascadeOnDelete(false);
        }
    }
}
