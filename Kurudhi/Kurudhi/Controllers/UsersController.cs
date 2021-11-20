using Microsoft.AspNetCore.Mvc;
using Kurudhi.Services;
using Kurudhi.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Kurudhi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UsersController : ControllerBase
    {
        private IUserService _userService;

        public UsersController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpPost("authenticate")]
        public IActionResult Authenticate(AuthenticateRequest model)
        {
            var response = _userService.Authenticate(model);

            if (response == null)
                return BadRequest(new { message = "Username or password is incorrect" });

            return Ok(response);
        }

        [HttpPost]
        public async Task<IActionResult> AddUser(User user)
        {
            var users = await _userService.AddUser(user).ConfigureAwait(false);
            return Ok(users);
        }

        [Authorize]
        [HttpPatch]
        public async Task<IActionResult> UpdateUser(User user)
        {
            var users = await _userService.UpdateUser(user).ConfigureAwait(false);
            return Ok(users);
        }

        [Authorize]
        [HttpGet]
#nullable enable
        public async Task<IActionResult> GetUsers(string? district)
        {
            IList<User> usersLists = await _userService.GetAllUsersbydistrict(district).ConfigureAwait(false);
#nullable disable
            return Ok(usersLists);
        }
    }
}
