using System;
using System.Collections.Generic;

#nullable disable

namespace Kurudhi.Models
{
    public partial class PatientInfo
    {
        public int Id { get; set; }
        public string PatientId { get; set; }
        public string PatientName { get; set; }
        public int Age { get; set; }
        public string HospitalName { get; set; }
        public string HospitalAddress { get; set; }
        public string PatientStatus { get; set; }
        public string AttenderName { get; set; }
        public int AttenderContactno { get; set; }
        public string District { get; set; }
        public string Location { get; set; }
    }
}
