using Repository.SQL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LottoSyncService
{
    public class Constants
    {
        public const string LogName = "LottoSyncServiceLog";
        public const string LogSource = "LottoSyncServiceLogSource";
        public static Dictionary<string, int> LottoNumbers = new Dictionary<string, int>
        {
            {"BC49", 49 },
            {"Lottery", 49 },
            {"LottoMax", 49 },

        };

        public static Dictionary<string, string> ProcNameDic = new Dictionary<string, string>
        {
            {"BC49", "SyncBC49" },
            {"Lottery", "SyncLotto649" },
            {"LottoMax", "SyncLottoMax" },

        };



    }






    public class LottoIDs
    {
        public const int BC49 = 2;
    }
}
