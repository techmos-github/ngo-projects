using Kurudhi.Models.Contracts;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Kurudhi.Models.Features
{
    public class BloodRequestFeature : IBloodRequest
    {
        private Kurudhi_DBContext dbContext;

        public BloodRequestFeature()
        {
            dbContext = new Kurudhi_DBContext();
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposing)
            {
                dbContext?.Dispose();
            }
        }


        public async Task<BloodRequest> GetBloodRequestById(int id) => await dbContext.BloodRequests.FindAsync(id);

        public async Task<IList<BloodRequest>> GetBloodRequestByRequestStatus(string requestStatus) => await dbContext.BloodRequests.Where(x=>x.RequestStatus.Equals(requestStatus)).ToListAsync();

        public async Task<BloodRequest> AddBloodRequest(BloodRequest bloodRequest)
        {
            var dbObj = await dbContext.BloodRequests.FindAsync(bloodRequest.Id).ConfigureAwait(false);
            if (dbObj == null)
            {
                //bloodRequest.ActiveStatus = 1;
                dbContext.Add(bloodRequest);
                await dbContext.SaveChangesAsync();
                return bloodRequest;
            }
            else
                return dbObj;
        }
        public async Task<BloodRequest> UpdateBloodRequest(BloodRequest bloodRequest)
        {
            var dbObj = await dbContext.BloodRequests.FindAsync(bloodRequest.Id).ConfigureAwait(false);
            if (dbObj == null)
            {
                dbContext.Update(bloodRequest);
                await dbContext.SaveChangesAsync();
                return bloodRequest;
            }
            else
                return await AddBloodRequest(bloodRequest).ConfigureAwait(false);
        }
    }
}
