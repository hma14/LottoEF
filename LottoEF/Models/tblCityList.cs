namespace LottoEF.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("tblCityList")]
    public partial class tblCityList
    {
        [Key]
        [StringLength(25)]
        public string cityName { get; set; }
    }
}
