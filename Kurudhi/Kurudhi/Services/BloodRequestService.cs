using Kurudhi.Helpers;
using Kurudhi.Models;
using Kurudhi.Models.Contracts;
using Microsoft.Extensions.Options;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Kurudhi.Services
{
    public interface IBloodRequestService
    {
        Task<BloodRequest> AddBloodRequest(BloodRequest bloodRequest);
        Task<IList<BloodRequest>> GetBloodRequestbyStatus(string requestStatus);
        Task<BloodRequest> UpdateBloodRequest(BloodRequest bloodRequest);
    }
    public class BloodRequestService : IBloodRequestService
    {
        private readonly AppSettings _appSettings;
        private IBloodRequest _bloodRequest;

        public BloodRequestService(IOptions<AppSettings> appSettings, IBloodRequest bloodRequest)
        {
            _appSettings = appSettings.Value;
            _bloodRequest = bloodRequest;
        }

        public async Task<IList<BloodRequest>> GetBloodRequestbyStatus(string requestStatus) => await _bloodRequest.GetBloodRequestByRequestStatus(requestStatus).ConfigureAwait(false);

        public async Task<BloodRequest> AddBloodRequest(BloodRequest bloodRequest) => await _bloodRequest.AddBloodRequest(bloodRequest).ConfigureAwait(false);

        public async Task<BloodRequest> UpdateBloodRequest(BloodRequest bloodRequest) => await _bloodRequest.UpdateBloodRequest(bloodRequest).ConfigureAwait(false);
    }
}
