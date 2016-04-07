using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Service;
using Autofac;
using Repository.SQL;
using Model;


namespace LottoSyncService
{
    public class LottoSync
    {
        private static ISyncService syncService;
        private const string LASTRUNSETTING = "Lotto - {0}: Sync Version";
        //private static readonly ILogger Logger = LogManager.GetCurrentClassLogger();

        static LottoSync()
        {

            using (var scope = IoCContainer.BaseContainer.BeginLifetimeScope())
            {
                syncService = scope.Resolve<ISyncService>();
            }

        }

        public static long GetLastVersion(string tableName)
        {
            //format
            string dbVersionId = syncService.GetSetting(string.Format(LASTRUNSETTING, tableName));
            long versionId;
            if (dbVersionId == null)
            {
                versionId = 0;
            }
            else if (!long.TryParse(dbVersionId, out versionId))
            {
                throw new Exception("Lotto Service: Last Sync Version setting can not be parsed into an a long");
            }
            return versionId;
        }
        public static void SetLastVersion(string tableName, long versionid)
        {
            syncService.SetSetting(string.Format(LASTRUNSETTING, tableName), versionid.ToString());
        }

        public void Start()
        {
            //Logger.Info("Starting Polling");
            Console.WriteLine("Starting Polling");
            try
            {
                TrackingBC49();
            }
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                Console.WriteLine(ex.Message);
            }

            //Logger.Info("Finished Polling");
            Console.WriteLine("Finished Polling");


        }

        private void TrackingBC49()
        {
            try
            {
                //Logger.Info("Syncing BC49");
                Console.WriteLine("Syncing BC49");

                long versionid = GetLastVersion(Tables.BC49);
                SyncResult<BC49> draws = syncService.GetSyncBC49(versionid);

                //Logger.Info("Detected {0} changes for {1}", draws.Count, Tables.BC49);
                Console.WriteLine(string.Format("Detected {0} changes for {1}", draws.Count, Tables.BC49));

                List<int> numbers = new List<int>();
                List<tblNumberInfo> numberInfos = new List<tblNumberInfo>();
                int[] dist = new int[100];
                for (int i = 0; i < LottoNumbers.BC49; i++)
                {
                    numbers.Add(i + 1);
                    dist[i + 1] = 0;
                }
                // get last row in tblNumberInfo table
                var lastdraw = syncService.GetLastRow(LottoIDs.BC49);
                
                foreach (var draw in draws)
                {
                    //if (draw.FieldsChanged == 0) continue;
                    
                    foreach (var n in numbers)
                    {

                        tblNumberInfo info = new tblNumberInfo();
                        info.LottoId = LottoIDs.BC49;

                        info.Number = n;
                        info.DrawNo = draw.DrawNumber;
                        info.DrawDate = Convert.ToDateTime(draw.DrawDate);
                        if (lastdraw != null)
                        {
                            info.Distance = lastdraw.Distance;
                        }
                        else
                        {
                            info.Distance = dist[n];
                        }

                        if (n == draw.Number1 || n == draw.Number2 ||
                            n == draw.Number3 || n == draw.Number4 || n == draw.Number5 || n == draw.Number6 || n == draw.Bonus)
                        {
                            info.isHit = true;
                        }
                        else
                        {
                            info.isHit = false;
                        }
                        Increment(ref info);

                        numberInfos.Add(info);
                        dist[n] = info.Distance;
                    }
                }
                if (numberInfos.Count > 0)
                {
                    syncService.InsertDraws(numberInfos);
                    SetLastVersion(Tables.BC49, draws.VersionId);
                }

            }
            catch (Exception e)
            {
                //Logger.Error(e.Message);
                Console.WriteLine(e.Message);
            }
        }

        private void Increment(ref tblNumberInfo  info)
        {
            info.Distance++;
            if (info.isHit)
            {
                info.SavedDistance = info.Distance;
                info.Distance = 0;
            }
        }
    }
}

