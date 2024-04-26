using System;
using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();


// Read appsettings.json
// IConfiguration config = new ConfigurationBuilder()
//                     .AddJsonFile("appsettings.json", optional: false, reloadOnChange: false).Build();
// var myConfiguration = config.GetSection("myConfiguration").Get<MyConfiguration>();
// Console.Write(myConfiguration.MyProperty);

var app = builder.Build();

app.UseAuthorization();

app.MapControllers();

Console.WriteLine("Environment: " + app.Environment.EnvironmentName);

app.Run("http://localhost:8000");
