using Model;
using Repository.SQL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Lotto
{
    public class SyncService : ISyncService
    {
        private IRepository _repository { get; set; }

        public SyncService(IRepository repository)
        {
            _repository = repository;
        }

        public string GetSetting(string name)
        {
            return _repository.GetSetting(name);
        }

        public void SetSetting(string name, string value)
        {
            _repository.SetSetting(name, value);
        }

        public SyncResult<BC49> GetSyncBC49(long lastVersion)
        {
            return _repository.GetSyncBC49(lastVersion);
        }

        public List<tblNumberInfo> GetLastRow(int lottoId)
        {
            return _repository.GetLastRow(lottoId);
        }

        public void InsertDraws(List<tblNumberInfo> numberInfos)
        {
            _repository.InsertDraws(numberInfos);
        }
        public tblNumberInfo GetLastDrawNo(int lottoId)
        {
            return _repository.GetLastDrawNo(lottoId);
        }
    }
}
