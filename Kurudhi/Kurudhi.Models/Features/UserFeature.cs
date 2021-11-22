using Kurudhi.Models.Contracts;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace Kurudhi.Models.Features
{
    public class UserFeature : IUser
    {
        private Kurudhi_DBContext dbContext;

        public UserFeature()
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

        public async Task<User> GetUserbyLogin(AuthenticateRequest request)
        {
            try
            {
                return await dbContext.Users.Where(x => x.Emailid.ToLower().Equals(request.Username.ToLower()) && x.Password.Equals(request.Password)).FirstOrDefaultAsync();
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public async Task<User> GetUserbyId(int Id) => await dbContext.Users.FindAsync(Id);

        public async Task<IList<User>> GetAllUsers() => await dbContext.Users.ToListAsync();

        public async Task<IList<User>> GetUsersbyDistrict(string district) => await dbContext.Users.Where(x=>x.District.Equals(district,StringComparison.OrdinalIgnoreCase)).ToListAsync();

        public async Task<User> AddUser(User user)
        {
            var dbObj = await dbContext.Users.FirstOrDefaultAsync(x => x.Emailid.ToLower().Equals(user.Emailid.ToLower())).ConfigureAwait(false);
            if(dbObj == null)
            {
                user.ActiveStatus = 1;
                dbContext.Add(user);
                await dbContext.SaveChangesAsync();
                return user;
            }
            else
                return dbObj;
        }

        public async Task<User> UpdateUser(User user)
        {
            var dbObj = await dbContext.Users.FindAsync(user.Id).ConfigureAwait(false);
            if (dbObj != null)
            {
                dbContext.Update(user);
                await dbContext.SaveChangesAsync().ConfigureAwait(false);
                return user;
            }
            else
                return await AddUser(user).ConfigureAwait(false);
        }
    }
}
