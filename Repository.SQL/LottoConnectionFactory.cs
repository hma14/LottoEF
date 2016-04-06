using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.SQL.EntityFramework
{
    public class LottoConnectionFactory
    {
        public static System.Data.Common.DbConnection CreateConnection(string nameOrConnectionString)
        {
            var setting = System.Configuration.ConfigurationManager.ConnectionStrings[nameOrConnectionString];

            SqlConnectionStringBuilder sb = new SqlConnectionStringBuilder(setting.ConnectionString);
            //if (!string.IsNullOrEmpty(sb.Password))
            //{
            //    sb.Password = Crypto.Decrypt(sb.Password);
            //}

            return new SqlConnection(sb.ToString());
        }
    }
}
