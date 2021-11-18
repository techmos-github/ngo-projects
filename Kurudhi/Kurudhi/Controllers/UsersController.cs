using Microsoft.AspNetCore.Mvc;
using Kurudhi.Services;
using Kurudhi.Models;

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

        [Authorize]
        [HttpPost]
        public IActionResult AddUser(User user)
        {
            var users = _userService.AddUser(user);
            return Ok(users);
        }

        [Authorize]
        [HttpPatch]
        public IActionResult UpdateUser(User user)
        {
            var users = _userService.UpdateUser(user);
            return Ok(users);
        }
    }
}
