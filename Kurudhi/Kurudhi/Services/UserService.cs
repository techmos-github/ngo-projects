using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using Kurudhi.Helpers;
using Kurudhi.Models;
using Kurudhi.Models.Contracts;
using System.Threading.Tasks;

namespace Kurudhi.Services
{
    public interface IUserService
    {
        Task<AuthenticateResponse> Authenticate(AuthenticateRequest model);
        Task<User> AddUser(User user);
        Task<User> UpdateUser(User user);
        Task<User> GetUserById(int Id);
        Task<IList<User>> GetAllUsersbydistrict(string? district);
    }

    public class UserService : IUserService
    {
        private readonly AppSettings _appSettings;
        private IUser _users;

        public UserService(IOptions<AppSettings> appSettings,IUser user)
        {
            _appSettings = appSettings.Value;
            _users = user;
        }

        public async Task<AuthenticateResponse> Authenticate(AuthenticateRequest model)
        {
            var user = await _users.GetUserbyLogin(model).ConfigureAwait(false);

            // return null if user not found
            if (user == null) return null;

            // authentication successful so generate jwt token
            var token = generateJwtToken(user);

            return new AuthenticateResponse(user, token);
        }

        public async Task<User> AddUser(User user) => await _users.AddUser(user).ConfigureAwait(false);
        public async Task<User> UpdateUser(User user) => await _users.UpdateUser(user).ConfigureAwait(false);
        public async Task<User> GetUserById(int Id) => await _users.GetUserbyId(Id).ConfigureAwait(false);
        
        #nullable enable
        public async Task<IList<User>> GetAllUsersbydistrict(string? district)
        {
            return string.IsNullOrEmpty(district) ? await _users.GetAllUsers().ConfigureAwait(false) : await _users.GetUsersbyDistrict(district).ConfigureAwait(false);
        #nullable disable
        }

        #region private
        private string generateJwtToken(User user)
        {
            // generate token that is valid for 7 days
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] { new Claim("id", user.Id.ToString()) }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
        #endregion private
    }
}