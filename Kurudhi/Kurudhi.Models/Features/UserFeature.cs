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

        public UserFeature(Kurudhi_DBContext context)
        {
            dbContext = context;
        }

        public async Task<User> GetUserbyLogin(AuthenticateRequest request)
        {
            return await dbContext.Users.FirstOrDefaultAsync(x => x.Emailid.Equals(request.Username, StringComparison.OrdinalIgnoreCase) && x.Password.Equals(request.Password));
        }

        public async Task<User> GetUserbyId(int Id) => await dbContext.Users.FindAsync(Id);

        public async Task<User> AddUser(User user)
        {
            var dbObj = await dbContext.Users.FirstOrDefaultAsync(x => x.Emailid.Equals(user.Emailid, StringComparison.OrdinalIgnoreCase)).ConfigureAwait(false);
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
