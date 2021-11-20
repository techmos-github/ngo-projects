using Kurudhi.Models;
using Kurudhi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Kurudhi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class BloodRequestController : ControllerBase
    {
        private IBloodRequestService _bloodRequestService;

        public BloodRequestController(IBloodRequestService bloodRequestService)
        {
            _bloodRequestService = bloodRequestService;
        }

        [Authorize]
        [HttpPost]
        public async Task<IActionResult> AddBloodRequest(BloodRequest bloodRequest)
        {
            var bloodRequestRsp = await _bloodRequestService.AddBloodRequest(bloodRequest).ConfigureAwait(false);
            return Ok(bloodRequestRsp);
        }

        [Authorize]
        [HttpPatch]
        public async Task<IActionResult> UpdateBloodRequest(BloodRequest bloodRequest)
        {
            var bloodRequestRsp = await _bloodRequestService.UpdateBloodRequest(bloodRequest).ConfigureAwait(false);
            return Ok(bloodRequestRsp);
        }

        [Authorize]
        [HttpGet]
        public async Task<IActionResult> GetBloodRequestByStatus(string requestStatus)
        {
            IList<BloodRequest> bloodRequestLists = await _bloodRequestService.GetBloodRequestbyStatus(requestStatus).ConfigureAwait(false);

            return Ok(bloodRequestLists);
        }
    }
}
