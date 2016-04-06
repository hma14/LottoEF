
using Model;
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
        SyncResult<BC49> GetSyncBC49(long lastVersion);
        tblNumberInfo GetLastRow(int lottoId);
        void InsertDraws(List<tblNumberInfo> numberInfos);
    }
}
