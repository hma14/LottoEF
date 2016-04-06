using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class NumberInfo
    {
        public int Number { get; set; }
        public int LottoId { get; set; }
        public int DrawNo { get; set; }
        public DateTime DrawDate { get; set; }
        public int Distance { get; set; }
        public int SavedDistance { get; set; }
        public bool isHit { get; set; }

        public void Incrememt()
        {
            Distance++;
            if (isHit)
            {
                SavedDistance = Distance;
                Distance = 0;
            }           
        }
    }
}
