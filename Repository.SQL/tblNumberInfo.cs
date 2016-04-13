namespace Repository.SQL
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblNumberInfo")]
    public partial class tblNumberInfo
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        public long Id { get; set; }
        
        public int Number { get; set; }

        public int LottoId { get; set; }

        public int DrawNo { get; set; }
        public DateTime DrawDate { get; set; }

        public int Distance { get; set; }

        public int SavedDistance { get; set; }

        public bool isHit { get; set; }
        public int Frequncy { get; set; }
    }
}
