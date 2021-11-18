using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Kurudhi.Models.Contracts
{
    public interface IUser
    {
        Task<User> AddUser(User user);
        Task<User> GetUserbyId(int Id);
        Task<User> GetUserbyLogin(AuthenticateRequest request);
        Task<User> UpdateUser(User user);
    }
}
