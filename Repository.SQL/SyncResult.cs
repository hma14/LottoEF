using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.SQL
{
    public class SyncResult<T> : List<T>
    {
        public long VersionId { get; set; }

    }
}
