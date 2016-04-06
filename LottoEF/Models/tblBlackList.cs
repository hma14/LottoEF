namespace LottoEF.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblBlackList")]
    public partial class tblBlackList
    {
        [Key]
        public int ListID { get; set; }

        [Required]
        [StringLength(25)]
        public string UserID { get; set; }

        [Required]
        [StringLength(50)]
        public string Email { get; set; }
    }
}
