using System;
using System.Collections.Generic;
using System.Linq;
using CSharpx;
using Gabor.Features.Main.Models;
using LibGit2Sharp;

namespace Gabor.Features.Main.Services
{
    public class Creator : IDisposable
    {
        private readonly Repository _repository;

        public Creator(string path)
        {
            _repository = new Repository(path);
        }

        public void Dispose()
        {
            _repository?.Dispose();
        }

        /// <summary>
        ///     git rev-list --all --count
        /// </summary>
        /// <returns></returns>
        private int GetNumberCommits()
        {
            var l = new HashSet<string>();
            foreach (var repoBranch in _repository.Branches) repoBranch.Commits.ForEach(x => { l.Add(x.Sha); });
            return l.Count;
        }


        private string GetBranchName()
        {
            var r = _repository.Head.FriendlyName;
            return r;
        }

        private string GetCommitSha()
        {
            var r = _repository.Head.Commits.FirstOrDefault();
            return r.Sha;
        }

        private DateTimeOffset GetDataTime()
        {
            var r = _repository.Head.Commits.FirstOrDefault();
            return r.Author.When;
        }

        public Result Generate()
        {
            var r = new Result
            {
                NumberCommits = GetNumberCommits(),
                BranchName = GetBranchName(),
                CommitDateTime = GetDataTime(),
                CommitSha = GetCommitSha()
            };

            return r;
        }
    }
}