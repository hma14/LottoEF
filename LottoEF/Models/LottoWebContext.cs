namespace LottoEF.Models
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class LottoWebContext : DbContext
    {
        public LottoWebContext()
            : base("name=LottoWebContext")
        {
        }

        public virtual DbSet<tblNumberInfo> tblNumberInfoes { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
        }
    }
}
