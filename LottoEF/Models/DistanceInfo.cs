using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LottoEF.Models
{
    public class DistanceInfo
    {
        public int DrawNumber { get; set; }
        public DateTime DrawDate { get; set; }
        public Dictionary<int, int> dic;
        public int Total { get; set; }
        public DistanceInfo()
        {
            dic = new Dictionary<int, int>();
        }
    }
}