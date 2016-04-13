
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Model;
using System.Data;

namespace Repository.SQL
{
    public class Repository : IRepository
    {
        public string GetSetting(string name)
        {
            using (var ctx = new LottoContext())
            {
                var setting = ctx.Settings.Find(name);
                return setting == null ? null : setting.Value;
            }           
        }

        public void SetSetting(string name, string value)
        {
            using(var ctx = new LottoContext())
            {
                var setting = ctx.Settings.FirstOrDefault(x => x.Name == name);
                if (setting == null)
                {
                    ctx.Settings.Add(new Setting() { Name = name, Value = value });
                }
                else
                {
                    setting.Value = value;
                }
                ctx.SaveChanges();
            }
        }

        public SyncResult<BC49> GetSyncBC49(long lastVersion)
        {
            return GetSyncResults<BC49>(lastVersion, "SyncBC49");
        }

        public SyncResult<T> GetSyncResults<T>(long lastVersion, string procName)
        {
            using (var ctx = new LottoContext())
            {
                ctx.Database.Initialize(false);
                using (var connection = ctx.Database.Connection)
                {
                    connection.Open();
                    var cmd = connection.CreateCommand();
                    cmd.CommandText = string.Format("exec {0} @lastversion", procName);
                    SqlParameter param = new SqlParameter();
                    param.ParameterName = "@lastversion";
                    param.Value = lastVersion;
                    cmd.Parameters.Add(param);
                    //cmd.Parameters.Add(new SqlParameter("versionid", lastVersion));

                    using (var reader = cmd.ExecuteReader())
                    {
                        bool hasRecords = reader.Read();
                        if (!hasRecords) throw new Exception("Expecting version id from sync procedure");

                        long versionId = (long)reader[0];

                        reader.NextResult();

                        var items =
                            ((IObjectContextAdapter)ctx)
                                .ObjectContext
                                .Translate<T>(reader)
                                .ToList();

                        SyncResult<T> results = new SyncResult<T>();
                        results.VersionId = versionId;
                        results.AddRange(items);
                        return results;
                    }
                }
            }
        }

        public List<tblNumberInfo> GetLastRow(int lottoId)
        {
            using (var ctx = new LottoContext())
            {
                List<tblNumberInfo> result = new List<tblNumberInfo>();
                if (ctx.tblNumberInfoes.Count() > 0)
                {
                    var lastEntry = ctx.tblNumberInfoes.Where(x => x.LottoId == lottoId).AsEnumerable().ToList().Last();
                    if (lastEntry != null)
                    {
                        result = ctx.tblNumberInfoes.Where(x => x.LottoId == lottoId && x.DrawNo == lastEntry.DrawNo).AsEnumerable().ToList();
                    }
                }
                return result;
            }
        }

        public void InsertDraws(List<tblNumberInfo> numberInfos)
        {
            using (var ctx = new LottoContext())
            {
                ctx.tblNumberInfoes.AddRange(numberInfos);
                ctx.SaveChanges();
            }
        }
        public tblNumberInfo GetLastDrawNo(int lottoId)
        {
            using (var ctx = new LottoContext())
            {
                return ctx.tblNumberInfoes.Where(x => x.LottoId == lottoId).AsEnumerable().ToList().Last();
            }
        }
    }
}
