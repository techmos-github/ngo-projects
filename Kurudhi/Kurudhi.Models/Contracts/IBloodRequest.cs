using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Kurudhi.Models.Contracts
{
    public interface IBloodRequest
    {
        Task<BloodRequest> AddBloodRequest(BloodRequest bloodRequest);
        Task<IList<BloodRequest>> GetBloodRequestByRequestStatus(string requestStatus);
        Task<BloodRequest> UpdateBloodRequest(BloodRequest bloodRequest);
    }
}
