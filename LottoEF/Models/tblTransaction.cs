namespace LottoEF.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblTransaction
    {
        [Key]
        public int transEntry { get; set; }

        [StringLength(25)]
        public string transactionID { get; set; }

        [Column(TypeName = "money")]
        public decimal? amount { get; set; }

        [StringLength(25)]
        public string customerName { get; set; }

        [StringLength(25)]
        public string transType { get; set; }
    }
}
