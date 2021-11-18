using System;
using System.Collections.Generic;

#nullable disable

namespace Kurudhi.Models
{
    public partial class BloodRequest
    {
        public int Id { get; set; }
        public int PatientId { get; set; }
        public string RequestType { get; set; }
        public int BloodGroupId { get; set; }
        public int NoUnits { get; set; }
        public DateTime RequestedDate { get; set; }
        public DateTime DueDate { get; set; }
        public int ApprovedById { get; set; }
        public string ApprovedBy { get; set; }
        public DateTime ApprovedDate { get; set; }
        public string RequestStatus { get; set; }
        public int CreatedById { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime UpdatedDate { get; set; }
        public string UpdatedBy { get; set; }
        public int UpdatedById { get; set; }
    }
}
