using System;
using System.Collections.Generic;

#nullable disable

namespace Kurudhi.Models
{
    public partial class User
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Gender { get; set; }
        public int Age { get; set; }
        public int BloodGroupId { get; set; }
        public string Emailid { get; set; }
        public string Password { get; set; }
        public int Contactno { get; set; }
        public string District { get; set; }
        public string Location { get; set; }
        public byte[] UserProfilePhoto { get; set; }
        public int ActiveStatus { get; set; }
        public int DeletedStatus { get; set; }
        public int CreatedById { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime UpdatedDate { get; set; }
        public string UpdatedBy { get; set; }
        public int UpdatedById { get; set; }
    }
}
