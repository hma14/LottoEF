using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using LottoEF.Models;
using NLog;
using System.Web.Http.OData;
using System.Web.OData.Routing;

namespace LottoEF.Controllers
{
    public class tblNumberInfoesController : ApiController
    {
        private LottoWebContext db = new LottoWebContext();
        private static readonly Logger Logger = LogManager.GetCurrentClassLogger();

        // GET: api/tblNumberInfoes
        [EnableQuery]
        [ODataRoute]
        public IQueryable<tblNumberInfo> GettblNumberInfoes()
        {
            return db.tblNumberInfoes;
        }

        [EnableQuery]
        [ODataRoute]
        public List<List<tblNumberInfo>> GettblNumberInfoes(int lottoId, int startDrawNo)
        {
            Logger.Info(string.Format("GettblNumberInfoes(), lottoId: {0}, startDrawNo: {1}", lottoId, startDrawNo));
            var list = db.tblNumberInfoes.Where(x => x.LottoId == lottoId && x.DrawNo >= startDrawNo);
            List<List<tblNumberInfo>> nList = new List<List<tblNumberInfo>>();
            if (list != null && list.Count() > 0)
            {
                int lastDrawNo = list.AsQueryable().ToList().Last().DrawNo;
                for (int d = startDrawNo; d <= lastDrawNo; d++)
                {
                    var l = list.Where(x => x.DrawNo == d).ToList();
                    nList.Add(l);
                }
            }
            return nList;
            //return db.tblNumberInfoes.Where(x => x.LottoId == lottoId && x.DrawNo >= startDrawNo);
        }

        // GET: api/GettblNumberInfoes
        [EnableQuery]
        [ODataRoute]
        public List<List<tblNumberInfo>> GettblNumberInfoes(int lottoId, int startDrawNo, bool isDesc)
        {
            Logger.Info(string.Format("GettblNumberInfos(), lottoId: {0}, startDrawNo: {1}", lottoId, startDrawNo));
            var list = db.tblNumberInfoes.Where(x => x.LottoId == lottoId && x.DrawNo >= startDrawNo);

            List<List<tblNumberInfo>> nList = new List<List<tblNumberInfo>>();
            int lastDrawNo = list.AsQueryable().ToList().Last().DrawNo;
            for (int d = startDrawNo; d <= lastDrawNo; d++)
            {
                var l = list.Where(x => x.DrawNo == d).ToList();
                if (isDesc == true)
                {
                    nList.Add(l.OrderByDescending(x => x.Frequency).ToList());
                }
                else
                {
                    nList.Add(l.OrderBy(x => x.Frequency).ToList());
                }

            }
            return nList;
            //return db.tblNumberInfoes.Where(x => x.LottoId == lottoId && x.DrawNo >= startDrawNo);
        }

        // GET: api/GettblNumberInfoes
        [EnableQuery]
        [ODataRoute]
        public List<DistanceInfo> GettblNumberInfoes(int lottoId, int startDrawNo, int flag)
        {
            Logger.Info(string.Format("GettblNumberInfos(), lottoId: {0}, startDrawNo: {1}", lottoId, startDrawNo));
            var list = db.tblNumberInfoes.Where(x => x.LottoId == lottoId && x.DrawNo >= startDrawNo);

            List<DistanceInfo> nList = new List<DistanceInfo>();
            int lastDrawNo = list.AsQueryable().ToList().Last().DrawNo;
            for (int d = startDrawNo; d <= lastDrawNo; d++)
            {
                var l = list.Where(x => x.DrawNo == d).ToArray();
                DistanceInfo di = new DistanceInfo();
                for(int i = 0; i < 200; i++)
                {
                    di.dic[i] = 0;
                }
                di.DrawNumber = l.First().DrawNo;
                di.DrawDate = l.First().DrawDate;
                int total = 0;
                for (int i = 0; i < l.Length; i++)
                {
                    if (l[i].isHit == true)
                    {
                        di.dic[l[i].SavedDistance]++;
                        if (l[i].SavedDistance <= 10)
                        {
                            total++;
                        }
                    }                    
                }
                di.Frequency = l.First().Frequency;
                di.Total = total;
                nList.Add(di);
            }
            return nList;
        }


        // GET: api/tblNumberInfoes/5
        [ResponseType(typeof(tblNumberInfo))]
        public async Task<IHttpActionResult> GettblNumberInfo(long id)
        {
            tblNumberInfo tblNumberInfo = await db.tblNumberInfoes.FindAsync(id);
            if (tblNumberInfo == null)
            {
                return NotFound();
            }

            return Ok(tblNumberInfo);
        }

        // PUT: api/tblNumberInfoes/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PuttblNumberInfo(long id, tblNumberInfo tblNumberInfo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != tblNumberInfo.Id)
            {
                return BadRequest();
            }

            db.Entry(tblNumberInfo).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!tblNumberInfoExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/tblNumberInfoes
        [ResponseType(typeof(tblNumberInfo))]
        public async Task<IHttpActionResult> PosttblNumberInfo(tblNumberInfo tblNumberInfo)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.tblNumberInfoes.Add(tblNumberInfo);
            await db.SaveChangesAsync();

            return CreatedAtRoute("DefaultApi", new { id = tblNumberInfo.Id }, tblNumberInfo);
        }

        // DELETE: api/tblNumberInfoes/5
        [ResponseType(typeof(tblNumberInfo))]
        public async Task<IHttpActionResult> DeletetblNumberInfo(long id)
        {
            tblNumberInfo tblNumberInfo = await db.tblNumberInfoes.FindAsync(id);
            if (tblNumberInfo == null)
            {
                return NotFound();
            }

            db.tblNumberInfoes.Remove(tblNumberInfo);
            await db.SaveChangesAsync();

            return Ok(tblNumberInfo);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool tblNumberInfoExists(long id)
        {
            return db.tblNumberInfoes.Count(e => e.Id == id) > 0;
        }
    }
}