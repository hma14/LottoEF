﻿

using Repository.SQL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.SQL
{
    public interface IRepository
    {
        string GetSetting(string name);
        void SetSetting(string name, string value);
        SyncResult<T> GetSyncResults<T>(long lastVersion, string procName);
        List<tblNumberInfo> GetLastRow(int lottoId);
        void InsertDraws(List<tblNumberInfo> numberInfos);
        tblNumberInfo GetLastDrawNo(int lottoId);
        List<Lotto> GetLottos();
        List<LottoName> GetLottoNames();
        SyncResult<BC49> GetSyncBC49(long lastVersion);
        SyncResult<Lottery> GetSyncLotto649(long lastVersion);
        SyncResult<LottoMax> GetSyncLottoMax(long lastVersion);


    }
}
