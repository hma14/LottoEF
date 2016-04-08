using NLog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;


namespace LottoSyncService
{
    class Program
    {
        private static readonly Logger Logger = LogManager.GetCurrentClassLogger();

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        public static void Main()
        {       
            Logger.Info(string.Format("UserInteractive: {0}", Environment.UserInteractive));
            IoCContainer.Build();

            if (Environment.UserInteractive)
            {
                #region Start as Console Application
                try
                {
                    LottoSync s = new LottoSync();
                    s.Start();

                    Logger.Info("Lotto Sync complete");
                }
                catch (Exception er)
                {
                    Console.WriteLine(er.Message);
                 }
                #endregion
            }
            else
            {
                #region Start as a Windows Service
                ServiceBase.Run(new LottoSyncService());
                #endregion
            }
        }
    }
}
