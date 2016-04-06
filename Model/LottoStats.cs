using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    public class LottoStats
    {
        public int LottoId { get; set; }
        public int DrawNo { get; set; }
        public DateTime DrawDate { get; set; }
        public int SumDrawNumbers { get; set; }
        public int NumberOdd { get; set; }
        public int NumberEven { get; set; }

    }
}
