using System;
using Gabor.Features.Main.Services;
using Newtonsoft.Json;

namespace Gabor
{
    internal class Program
    {
        private const string repoPath = "C:\\work\\AntyPiracy\\simple-scraper";


        private static void Main(string[] args)
        {
            var c = new Creator(repoPath);
            var r = c.Generate();

            Console.Write(JsonConvert.SerializeObject(r, Formatting.Indented));
            Console.ReadKey();
        }
    }
}