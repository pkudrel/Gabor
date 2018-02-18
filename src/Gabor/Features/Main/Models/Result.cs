using System;

namespace Gabor.Features.Main.Models
{
    public class Result
    {
        public int NumberCommits { get; set; }
        public string BranchName { get; set; }
        public string CommitSha { get; set; }
        public DateTimeOffset CommitDateTime { get; set; }
    }
}