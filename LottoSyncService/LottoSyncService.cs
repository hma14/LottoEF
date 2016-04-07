using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading;
using System.Threading.Tasks;



namespace LottoSyncService
{
    public partial class LottoSyncService : ServiceBase
    {
        public LottoSyncService()
        {
            InitializeComponent();

        }

        protected override void OnStart(string[] args)
        {
            this.ScheduleService();
        }

        protected override void OnStop()
        {
           

            this.Schedular.Dispose();
        }


        private Timer Schedular;
        //private readonly Logger Logger = LogManager.GetCurrentClassLogger();

        public void ScheduleService()
        {
            try
            {
                Schedular = new Timer(new TimerCallback(SchedularCallback));
                string mode = ConfigurationManager.AppSettings["Mode"].ToUpper();


                //Logger.Info(string.Format("LottoSync Service Mode: {0}", mode));

                //Set the Default Time.
                DateTime scheduledTime = DateTime.MinValue;

                if (mode == "DAILY")
                {
                    //Get the Scheduled Time from AppSettings.
                    scheduledTime = DateTime.Parse(ConfigurationManager.AppSettings["ScheduledTime"]);
                    if (DateTime.Now > scheduledTime)
                    {
                        //If Scheduled Time is passed set Schedule for the next day.
                        scheduledTime = scheduledTime.AddDays(1);
                    }
                }

                if (mode.ToUpper() == "INTERVAL")
                {
                    //Get the Interval in Minutes from AppSettings.
                    int intervalMinutes = Convert.ToInt32(ConfigurationManager.AppSettings["IntervalMinutes"]);

                    //Set the Scheduled Time by adding the Interval to Current Time.
                    scheduledTime = DateTime.Now.AddMinutes(intervalMinutes);
                    if (DateTime.Now > scheduledTime)
                    {
                        //If Scheduled Time is passed set Schedule for the next Interval.
                        scheduledTime = scheduledTime.AddMinutes(intervalMinutes);
                    }
                }

                TimeSpan timeSpan = scheduledTime.Subtract(DateTime.Now);
                string schedule = string.Format("{0} day(s) {1} hour(s) {2} minute(s) {3} seconds(s)", timeSpan.Days, timeSpan.Hours, timeSpan.Minutes, timeSpan.Seconds);

                //this.WriteToFile("Simple Service scheduled to run after: " + schedule + " {0}");
                //Logger.Info(string.Format("Simple Service scheduled to run after: {0}",  schedule));

                //Get the difference in Minutes between the Scheduled and Current Time.
                int dueTime = Convert.ToInt32(timeSpan.TotalMilliseconds);

                //Change the Timer's Due Time.
                Schedular.Change(dueTime, Timeout.Infinite);
            }
            catch (Exception ex)
            {
                //WriteToFile("Simple Service Error on: {0} " + ex.Message + ex.StackTrace);
                //Logger.Error(string.Format("Lotto Sync Service Error on: {0} ", ex.Message + ex.StackTrace));

                //Stop the Windows Service.
                using (System.ServiceProcess.ServiceController serviceController = new System.ServiceProcess.ServiceController("SyncService"))
                {
                    serviceController.Stop();
                }
            }
        }

        private void SchedularCallback(object e)
        {
            //this.WriteToFile("Simple Service Log: {0}");
            //Logger.Info("Lotto Syunc Service");
            this.ScheduleService();
        }

        
    }
}
