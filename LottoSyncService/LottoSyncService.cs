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
        private System.Diagnostics.EventLog eventLog;
        private System.Timers.Timer timer;
        private LottoSync s;

        public LottoSyncService()
        {
            InitializeComponent();
            eventLog = new System.Diagnostics.EventLog();
            if (!System.Diagnostics.EventLog.SourceExists(Constants.LogSource))
            {
                System.Diagnostics.EventLog.CreateEventSource(Constants.LogSource, Constants.LogName);
            }
            eventLog.Source = Constants.LogSource;
            eventLog.Log = Constants.LogName;
            s = new LottoSync();
        }

        protected override void OnStart(string[] args)
        {
            eventLog.WriteEntry("In OnStart");
            // Set up a timer to trigger every minute.
            timer = new System.Timers.Timer();
            double TimerInterval = (double)GetNextInterval();
            timer.Interval = TimerInterval;
            timer.Elapsed += new System.Timers.ElapsedEventHandler(this.OnTimer);
            timer.Start();
        }

        protected override void OnStop()
        {
            eventLog.WriteEntry("In OnStop");          
        }

        public void OnTimer(object sender, System.Timers.ElapsedEventArgs args)
        {
            eventLog.WriteEntry("Calling LottoSync Start()");
            s.Start();
            SetTimer();
        }

        private void SetTimer()
        {
            eventLog.WriteEntry("In SetTimer()");
            try
            {
                double inter = (double)GetNextInterval();
                timer.Interval = inter;
                timer.Start();
            }
            catch (Exception ex)
            {
                eventLog.WriteEntry(ex.Message);
            }
        }
        private double GetNextInterval()
        {
            eventLog.WriteEntry("In GetNextInterval()");
            string timeString = ConfigurationManager.AppSettings["ScheduledTime"];
           
            DateTime t = DateTime.Parse(timeString);
            TimeSpan ts = new TimeSpan();

            ts = t - System.DateTime.Now;
            eventLog.WriteEntry(string.Format("t = {0}, Now = {1}, ts = {2}", t, DateTime.Now, ts));

            if (ts.TotalMilliseconds < 0)
            {
                ts = t.AddDays(1) - System.DateTime.Now; //Here you can increase the timer interval based on your requirments.   
            }
            eventLog.WriteEntry(string.Format("{0:0.0} hours left to for next run", ts.TotalMilliseconds / 1000 / 60 / 60));
            return ts.TotalMilliseconds;
        }
    }
}
