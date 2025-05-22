using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Microsoft.AspNetCore.StaticFiles;
using System.IO;

var builder = WebApplication.CreateBuilder(args);

// Server URL ayarını Build() öncesinde yap
builder.WebHost.UseUrls("http://localhost:5001");

// Add services to the container.
builder.Services.AddControllers();

// Add CORS policy - Flutter gibi frontend'den çağıracaksan önemli
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

var app = builder.Build();

// MIME tipi provider oluştur
var provider = new FileExtensionContentTypeProvider();
provider.Mappings[".mov"] = "video/quicktime"; 
provider.Mappings[".mp4"] = "video/mp4";      

// Videolar için statik dosya servisi
app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(
        Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "videos")),
    RequestPath = "/videos",
    ContentTypeProvider = provider
});

// Resimler için statik dosya servisi (istersen ekle)
app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(
        Path.Combine(Directory.GetCurrentDirectory(), "wwwroot", "images")),
    RequestPath = "/images"
});

// Enable CORS policy
app.UseCors("AllowAll");

// Authorization middleware (varsa)
app.UseAuthorization();

// Controller route mapping
app.MapControllers();

app.Run();
