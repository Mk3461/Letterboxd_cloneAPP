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
app.UseStaticFiles();

// Enable CORS
app.UseCors("AllowAll");

// Optional: redirect HTTP to HTTPS — kaldırabilirsin
// app.UseHttpsRedirection(); // kaldırırsan uyarı mesajı da gider

app.UseAuthorization();

app.MapControllers(); // << BU ÇOK ÖNEMLİ

app.Run();
