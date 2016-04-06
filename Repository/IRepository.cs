
using Repository.SQL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository
{
    public interface IRepository
    {
        SyncResult<T> GetSyncResults<T>(long lastVersion, string procName);
        SyncResult<BC49> GetSyncBC49(long lastVersion);
    }
}
