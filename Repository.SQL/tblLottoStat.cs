namespace Repository.SQL
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblLottoStat
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int LottoId { get; set; }

        public int DrawNo { get; set; }

        public DateTime DrawDate { get; set; }

        public int SumDrawNumbers { get; set; }

        public int NumberOdd { get; set; }

        public int NumberEven { get; set; }
    }
}
