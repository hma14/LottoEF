namespace LottoEF.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class tblUser
    {
        [Key]
        [StringLength(20)]
        public string UserName { get; set; }

        [Required]
        [StringLength(200)]
        public string PasswordHash { get; set; }

        [Required]
        [StringLength(50)]
        public string userFName { get; set; }

        [Required]
        [StringLength(50)]
        public string userLName { get; set; }

        [Required]
        [StringLength(50)]
        public string userEmail { get; set; }

        [StringLength(20)]
        public string userRole { get; set; }

        public DateTime? signupDate { get; set; }

        public DateTime? expiryDate { get; set; }

        public int? isLoggedIn { get; set; }

        [StringLength(50)]
        public string userCity { get; set; }

        [StringLength(50)]
        public string userCountry { get; set; }
    }
}
