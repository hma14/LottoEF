using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Service;
using Autofac;
using Repository.SQL;
using NLog;
using System.Diagnostics;

namespace LottoSyncService
{
    public class LottoSync
    {
        private static ISyncService syncService;
        private const string LASTRUNSETTING = "Lotto - {0}: Sync Version";
        private static readonly Logger Logger = LogManager.GetCurrentClassLogger();
        private System.Diagnostics.EventLog eventLog;

        static LottoSync()
        {

            using (var scope = IoCContainer.BaseContainer.BeginLifetimeScope())
            {
                syncService = scope.Resolve<ISyncService>();
            }
        }

        public LottoSync()
        {
            eventLog = new System.Diagnostics.EventLog();
            if (!System.Diagnostics.EventLog.SourceExists(Constants.LogSource))
            {
                System.Diagnostics.EventLog.CreateEventSource(Constants.LogSource, Constants.LogName);
            }
            eventLog.Source = Constants.LogSource;
            eventLog.Log = Constants.LogName;
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
            Logger.Info(string.Format("Last version: {0}", versionId));
            return versionId;
        }
        public static void SetLastVersion(string tableName, long versionid)
        {
            syncService.SetSetting(string.Format(LASTRUNSETTING, tableName), versionid.ToString());
        }

        public void Start()
        {
            Logger.Info("Starting Polling");
            eventLog.WriteEntry("Starting Polling");

            try
            {
                List<LottoName> lottoNames = syncService.GetLottoNames();

                TrackingLottery(lottoNames[0]);
                TrackingLottoMax(lottoNames[1]);
                TrackingBC49(lottoNames[2]);

            }
            catch (Exception ex)
            {
                Logger.Error(ex.Message);
                eventLog.WriteEntry(ex.Message);
            }
            Logger.Info("Finished Polling");
            eventLog.WriteEntry("Finished Polling");
        }
#if false
        private void TrackingBC49()
        {
            try
            {
                //Logger.Info("Syncing BC49");
                eventLog.WriteEntry("Syncing BC49");

                long versionid = GetLastVersion(Tables.BC49);
                SyncResult<BC49> draws = syncService.GetSyncBC49(versionid);

                //Logger.Info("Detected {0} changes for {1}", draws.Count, Tables.BC49);
                eventLog.WriteEntry(string.Format("Detected {0} changes for {1}", draws.Count, Tables.BC49));

                List <int> numbers = new List<int>();
                List<tblNumberInfo> numberInfos = new List<tblNumberInfo>();
                int[] dist = new int[100];
                int[] freq = new int[100];
                for (int i = 0; i < Constants.LottoNumbers["BC49"]; i++)
                {
                    numbers.Add(i + 1);
                    dist[i + 1] = 0;
                    freq[i + 1] = 0;
                }
                // get last row in tblNumberInfo table
                var lastRow = syncService.GetLastRow(LottoIDs.BC49);
                
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
                        if (lastRow.Count > 0)
                        {
                            info.Distance = lastRow[n-1].Distance;
                            info.Frequency = lastRow[n - 1].Frequency;
                        }
                        else
                        {
                            info.Distance = dist[n];
                            info.Frequency = freq[n];
                        }

                        if (n == draw.Number1 || n == draw.Number2 ||
                            n == draw.Number3 || n == draw.Number4 || 
                            n == draw.Number5 || n == draw.Number6 || 
                            n == draw.Bonus)
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
                        freq[n] = info.Frequency;
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
                eventLog.WriteEntry(e.Message + ",  InnerException: " + e.InnerException);
            }
        }

#endif
        #region TrackingLottery
        private void TrackingLottery(LottoName lotto)
        {
            try
            {
                Logger.Info(string.Format("Syncing {0}", lotto.name));
                eventLog.WriteEntry(string.Format("Syncing {0}", lotto.name));

                long versionid = GetLastVersion(lotto.name);
                SyncResult<Lottery> draws = syncService.GetSyncResults<Lottery>(versionid, Constants.ProcNameDic[lotto.name]);

                Logger.Info("Detected {0} changes for {1}", draws.Count, lotto.name);
                
                eventLog.WriteEntry(string.Format("Detected {0} changes for {1}", draws.Count, lotto.name));

                List<int> numbers = new List<int>();
                List<tblNumberInfo> numberInfos = new List<tblNumberInfo>();
                int[] dist = new int[100];
                int[] freq = new int[100];
                for (int i = 0; i < Constants.LottoNumbers[lotto.name]; i++)
                {
                    numbers.Add(i + 1);
                    dist[i + 1] = 0;
                    freq[i + 1] = 0;
                }
                // get last row in tblNumberInfo table
                var lastRow = syncService.GetLastRow(lotto.id);

                foreach (var draw in draws)
                {
                    foreach (var n in numbers)
                    {
                        tblNumberInfo info = new tblNumberInfo();
                        info.LottoId = lotto.id;

                        info.Number = n;
                        info.DrawNo = draw.DrawNumber;
                        info.DrawDate = Convert.ToDateTime(draw.DrawDate);
                        if (lastRow != null && lastRow.Count > 0)
                        {
                            info.Distance = lastRow[n - 1].Distance;
                            info.Frequency = lastRow[n - 1].Frequency;
                        }
                        else
                        {
                            info.Distance = dist[n];
                            info.Frequency = freq[n];
                        }

                        if (n == draw.Number1 || n == draw.Number2 ||
                            n == draw.Number3 || n == draw.Number4 ||
                            n == draw.Number5 || n == draw.Number6 ||
                            n == draw.Bonus)
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
                        freq[n] = info.Frequency;
                    }
                }
                if (numberInfos.Count > 0)
                {
                    syncService.InsertDraws(numberInfos);
                    SetLastVersion(lotto.name, draws.VersionId);
                }

            }
            catch (Exception e)
            {
                Logger.Error(e.Message + ",  InnerException: " + e.InnerException);
                eventLog.WriteEntry(e.Message + ",  InnerException: " + e.InnerException);
            }
        }
        #endregion

        #region TrackingLottoMax
        private void TrackingLottoMax(LottoName lotto)
        {
            try
            {
                Logger.Info(string.Format("Syncing {0}", lotto.name));
                eventLog.WriteEntry(string.Format("Syncing {0}", lotto.name));

                long versionid = GetLastVersion(lotto.name);
                SyncResult<LottoMax> draws = syncService.GetSyncResults<LottoMax>(versionid, Constants.ProcNameDic[lotto.name]);

                Logger.Info("Detected {0} changes for {1}", draws.Count, lotto.name);

                eventLog.WriteEntry(string.Format("Detected {0} changes for {1}", draws.Count, lotto.name));

                List<int> numbers = new List<int>();
                List<tblNumberInfo> numberInfos = new List<tblNumberInfo>();
                int[] dist = new int[100];
                int[] freq = new int[100];
                for (int i = 0; i < Constants.LottoNumbers[lotto.name]; i++)
                {
                    numbers.Add(i + 1);
                    dist[i + 1] = 0;
                    freq[i + 1] = 0;
                }
                // get last row in tblNumberInfo table
                var lastRow = syncService.GetLastRow(lotto.id);

                foreach (var draw in draws)
                {
                    foreach (var n in numbers)
                    {
                        tblNumberInfo info = new tblNumberInfo();
                        info.LottoId = lotto.id;

                        info.Number = n;
                        info.DrawNo = draw.DrawNumber;
                        info.DrawDate = Convert.ToDateTime(draw.DrawDate);
                        if (lastRow != null && lastRow.Count > 0)
                        {
                            info.Distance = lastRow[n - 1].Distance;
                            info.Frequency = lastRow[n - 1].Frequency;
                        }
                        else
                        {
                            info.Distance = dist[n];
                            info.Frequency = freq[n];
                        }

                        if (n == draw.Number1 || n == draw.Number2 ||
                            n == draw.Number3 || n == draw.Number4 ||
                            n == draw.Number5 || n == draw.Number6 ||
                            n == draw.Number7 || n == draw.Bonus)
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
                        freq[n] = info.Frequency;
                    }
                }
                if (numberInfos.Count > 0)
                {
                    syncService.InsertDraws(numberInfos);
                    SetLastVersion(lotto.name, draws.VersionId);
                }

            }
            catch (Exception e)
            {
                Logger.Error(e.Message + ",  InnerException: " + e.InnerException);
                eventLog.WriteEntry(e.Message + ",  InnerException: " + e.InnerException);
            }
        }
        #endregion

        #region TrackingBC49
        private void TrackingBC49(LottoName lotto)
        {
            try
            {
                Logger.Info(string.Format("Syncing {0}", lotto.name));
                eventLog.WriteEntry(string.Format("Syncing {0}", lotto.name));

                long versionid = GetLastVersion(lotto.name);
                SyncResult<BC49> draws = syncService.GetSyncResults<BC49>(versionid, Constants.ProcNameDic[lotto.name]);

                Logger.Info("Detected {0} changes for {1}", draws.Count, lotto.name);

                eventLog.WriteEntry(string.Format("Detected {0} changes for {1}", draws.Count, lotto.name));

                List<int> numbers = new List<int>();
                List<tblNumberInfo> numberInfos = new List<tblNumberInfo>();
                int[] dist = new int[100];
                int[] freq = new int[100];
                for (int i = 0; i < Constants.LottoNumbers[lotto.name]; i++)
                {
                    numbers.Add(i + 1);
                    dist[i + 1] = 0;
                    freq[i + 1] = 0;
                }
                // get last row in tblNumberInfo table
                var lastRow = syncService.GetLastRow(lotto.id);

                foreach (var draw in draws)
                {
                    foreach (var n in numbers)
                    {
                        tblNumberInfo info = new tblNumberInfo();
                        info.LottoId = lotto.id;

                        info.Number = n;
                        info.DrawNo = draw.DrawNumber;
                        info.DrawDate = Convert.ToDateTime(draw.DrawDate);
                        if (lastRow != null && lastRow.Count > 0)
                        {
                            info.Distance = lastRow[n - 1].Distance;
                            info.Frequency = lastRow[n - 1].Frequency;
                        }
                        else
                        {
                            info.Distance = dist[n];
                            info.Frequency = freq[n];
                        }

                        if (n == draw.Number1 || n == draw.Number2 ||
                            n == draw.Number3 || n == draw.Number4 ||
                            n == draw.Number5 || n == draw.Number6 ||
                            n == draw.Bonus)
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
                        freq[n] = info.Frequency;
                    }
                }
                if (numberInfos.Count > 0)
                {
                    syncService.InsertDraws(numberInfos);
                    SetLastVersion(lotto.name, draws.VersionId);
                }

            }
            catch (Exception e)
            {
                Logger.Error(e.Message + ",  InnerException: " + e.InnerException);
                eventLog.WriteEntry(e.Message + ",  InnerException: " + e.InnerException);
            }
        }
        #endregion

        #region private methods
        private void Increment(ref tblNumberInfo  info)
        {
            info.Distance++;
            if (info.isHit)
            {
                info.SavedDistance = info.Distance;
                info.Distance = 0;
                info.Frequency++;
            }
        }
        #endregion
    }
}

