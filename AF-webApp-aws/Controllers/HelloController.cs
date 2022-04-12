using AF_webApp_aws.Model;
using Microsoft.AspNetCore.Mvc;

namespace AF_webApp_aws.Controllers;

[ApiController]
[Route("api/[Controller]")]
public class HelloController : Controller
{
    private const string ResponseMessage = "Hello from REST API";

    [HttpGet]
    public string GetAPIHelloResponse()
    {
        return ResponseMessage;
    }

    [HttpGet("model")]
    public HelloResponseModel GetAPIHelloResponseModel()
    {
        return new HelloResponseModel(ResponseMessage);
    }
}