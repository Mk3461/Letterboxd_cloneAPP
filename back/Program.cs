using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();

// Add CORS (isteğe bağlı ama Flutter'dan çağıracaksan şart)
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

// App configuration
var app = builder.Build();

// Use static files (optional, if you serve any static content)
app.UseStaticFiles();

// Set the server to listen on all IPs (0.0.0.0)
builder.WebHost.UseUrls("http://localhost:5001"); // This allows requests from any IP

// Enable CORS
app.UseCors("AllowAll");

// Optional: redirect HTTP to HTTPS — kaldırabilirsin
// app.UseHttpsRedirection(); // If you don't need HTTPS redirection, leave it commented

app.UseAuthorization();

app.MapControllers(); // Ensure controllers are properly mapped

app.Run();