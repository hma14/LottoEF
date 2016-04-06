namespace Repository.SQL
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblDistance")]
    public partial class tblDistance
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int LottoId { get; set; }

        public int DrawNo { get; set; }

        public int Distance { get; set; }

        public int Hits { get; set; }
    }
}
