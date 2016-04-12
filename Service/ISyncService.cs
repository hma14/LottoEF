using Model;
using Repository.SQL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service
{
    public interface ISyncService
    {
        string GetSetting(string name);
        void SetSetting(string name, string value);
        SyncResult<BC49> GetSyncBC49(long lastVersion);
        List<tblNumberInfo> GetLastRow(int lottoId);
        void InsertDraws(List<tblNumberInfo>  numberInfos);
        tblNumberInfo GetLastDrawNo(int lottoId);
    }
}
