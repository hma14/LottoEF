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
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        public static void Main()
        {
         
            Console.WriteLine();
            Console.WriteLine("UserInteractive: {0}", Environment.UserInteractive);

            IoCContainer.Build();

#if false
            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[]
            {
                new SyncService()
            };
            ServiceBase.Run(ServicesToRun);
#else
            if (Environment.UserInteractive)
            {
                #region Start as Console Application
                try
                {
                    LottoSync s = new LottoSync();
                    s.Start();

                    Console.WriteLine("Lotto Sync complete");
                    Console.ReadLine();
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
#endif
        }
    }
}
