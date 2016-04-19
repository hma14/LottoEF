using Repository.SQL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Lotteries
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
        public List<Lotto> GetLottos()
        {
            return _repository.GetLottos();
        }
        public List<LottoName> GetLottoNames()
        {
            return _repository.GetLottoNames();
        }
        public SyncResult<BC49> GetSyncBC49(long lastVersion)
        {
            return _repository.GetSyncBC49(lastVersion);
        }
        public SyncResult<Lottery> GetSyncLotto649(long lastVersion)
        {
            return _repository.GetSyncLotto649(lastVersion);
        }
        public SyncResult<LottoMax> GetSyncLottoMax(long lastVersion)
        {
            return _repository.GetSyncLottoMax(lastVersion);
        }

        public SyncResult<T> GetSyncResults<T>(long lastVersion, string procName)
        {
            return _repository.GetSyncResults<T>(lastVersion, procName);
        }
    }
}
