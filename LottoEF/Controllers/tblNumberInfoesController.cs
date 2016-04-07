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

namespace LottoEF.Controllers
{
    public class tblNumberInfoesController : ApiController
    {
        private LottoWebContext db = new LottoWebContext();

        // GET: api/tblNumberInfoes
        public IQueryable<tblNumberInfo> GettblNumberInfoes()
        {
            return db.tblNumberInfoes;
        }
        public List<List<tblNumberInfo>> GettblNumberInfoes(int lottoId, int startDrawNo)
        {
            
            var list = db.tblNumberInfoes.Where(x => x.LottoId == lottoId && x.DrawNo >= startDrawNo);
            List<List<tblNumberInfo>> nList = new List<List<tblNumberInfo>>();
            int lastDrawNo = list.AsQueryable().ToList().Last().DrawNo;
            for (int d = startDrawNo; d <= lastDrawNo; d++)
            {
                var l = list.Where(x => x.DrawNo == d).ToList();
                nList.Add(l);
            }
            return nList;
            //return db.tblNumberInfoes.Where(x => x.LottoId == lottoId && x.DrawNo >= startDrawNo);
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