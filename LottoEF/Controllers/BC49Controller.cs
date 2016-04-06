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
    public class BC49Controller : ApiController
    {
        private LottoDbContext db = new LottoDbContext();

        // GET: api/BC49
        public IQueryable<BC49> GetBC49()
        {
            return db.BC49;
        }

        // GET: api/BC49/5
        [ResponseType(typeof(BC49))]
        public IQueryable<BC49> GetBC49ByRange(int? start)
        {
            if (start.HasValue)
            {
                var entries = db.BC49
                    .Where(x => x.DrawNumber >= start);
                return entries;
            }
            else
            {
                return null;
            }
        }


        // GET: api/BC49/5
        [ResponseType(typeof(BC49))]
        public async Task<IHttpActionResult> GetBC49(int id)
        {
            BC49 bC49 = await db.BC49.FindAsync(id);
            if (bC49 == null)
            {
                return NotFound();
            }

            return Ok(bC49);
        }

        // PUT: api/BC49/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutBC49(int id, BC49 bC49)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != bC49.DrawNumber)
            {
                return BadRequest();
            }

            db.Entry(bC49).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BC49Exists(id))
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

        // POST: api/BC49
        [ResponseType(typeof(BC49))]
        public async Task<IHttpActionResult> PostBC49(BC49 bC49)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.BC49.Add(bC49);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (BC49Exists(bC49.DrawNumber))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = bC49.DrawNumber }, bC49);
        }

        // DELETE: api/BC49/5
        [ResponseType(typeof(BC49))]
        public async Task<IHttpActionResult> DeleteBC49(int id)
        {
            BC49 bC49 = await db.BC49.FindAsync(id);
            if (bC49 == null)
            {
                return NotFound();
            }

            db.BC49.Remove(bC49);
            await db.SaveChangesAsync();

            return Ok(bC49);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool BC49Exists(int id)
        {
            return db.BC49.Count(e => e.DrawNumber == id) > 0;
        }
    }
}